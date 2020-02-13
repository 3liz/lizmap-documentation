.. include:: ../../substitutions.rst

Action in a popup
=================

Principle
---------

This module allows to add **action buttons in the popup** which will trigger PostgreSQL queries and return a **geometry** to display on the map.

It reads a **JSON configuration file** which must be placed **aside the QGIS project**. This file lists the **PostgreSQL actions** to be added in the **popup** for one or many QGIS PostgreSQL vector layers.

Configuring the tool
--------------------

Each action is caracterized by a **layer**, a **name**, a **title**, an **icon**, some optional **options**, **style** and **callbacks**.

Example of this JSON configuration file, name :file:`myproject.qgs.action` if the QGIS project file is named :file:`myproject.qgs`:

.. code-block:: json

   {
       "points_a7e8943b_7138_4788_a775_f94cbd0ad8b6": [
           {
               "name": "liztest",
               "title": "Tampon",
               "icon": "icon-leaf",
               "options": {
                   "buffer_size": 5000
               },
               "style": {
                   "graphicName": "circle",
                   "pointRadius": 6,
                   "fill": true,
                   "fillColor": "lightblue",
                   "fillOpacity": 0.3,
                   "stroke": true,
                   "strokeWidth": 4,
                   "strokeColor": "blue",
                   "strokeOpacity": 0.8
               },
               "callbacks": [
                   {"method": "zoom"},
                   {"method": "select", "layerId": "admin_level_8_fcfdc9e0_c9b9_4563_b803_e36f9e2eca6a"},
                   {"method": "redraw", "layerId": "admin_level_8_fcfdc9e0_c9b9_4563_b803_e36f9e2eca6a"}
               ]
           }
       ]
   }

The JSON configuration file lists the QGIS layers for which you want to declare actions. Each layer is defined by its **QGIS ID**, for example here ``points_a7e8943b_7138_4788_a775_f94cbd0ad8b6``, and for each ID, a list of objects describing the actions to allow. Each **action** is an object defined by:

* a **name** which is the action identifier.
* a **title** which is used as a label in Lizmap interface
* an **icon** which is displayed on the action button ( See https://getbootstrap.com/2.3.2/base-css.html#icons )
* an **options** object, giving some additional parameters for this action.
* a **style** object allowing to configure the returned geometry style. It follows OpenLayers styling attributes.
* a **callbacks** object allows to trigger some actions after the generated geometry is returned. They are defined by a **method** name, which can at present be:

    -  **zoom**: zoom to the returned geometry
    -  **select**: select the features from a given layer intersecting the returned geometry. The target layer QGIS ID must be added in the **layerId** property
    -  **redraw**: redraw a given layer. The target layer QGIS ID must be added in the **layerId** property.

Lizmap detects the presence of this configuration file, and adds the needed logic when the map loads. When the users clicks on an object of one of this layer in the map, the **popup panel** shows the feature data. At the top of each popup item, **a toolbar will show one button per each layer action**.

Each button **triggers the corresponding action**:

* Lizmap backend checks if the action is well configured,
* creates the **PostgreSQL query** and execute it in the layer PostgreSQL database.
* This query returns a **GeoJSON** which is then displayed on the map.

The created query is build up by Lizmap web client and uses the PostgreSQL function ``lizmap_get_data(json)`` which **must be created beforehand in the PostgreSQL database**. This function also uses a more generic function ``query_to_geojson(text)`` which transforms any PostgreSQL query into a **GeoJSON output**.
Here is an example below of the query executed by Lizmap, for the example configuration given above, when the users clicks on the button action :guilabel:`liztest`, for the **feature** with id ``1`` of the **layer** ``points`` corresponding to the PostgreSQL **table** ``test.points``:

.. code-block:: postgresql

   SELECT public.lizmap_get_data('{"layer_name":"points","layer_schema":"test","layer_table":"points","feature_id":1,"action_name":"liztest","buffer_size":5000}') AS data


You can see that Lizmap creates a JSON parameters with all needed information and run the PostgreSQL function ``lizmap_get_data``. The following SQL code allows you to create the needed functions:

.. code-block:: postgresql

   -- Returns a valid GeoJSON from any query
   CREATE OR REPLACE FUNCTION query_to_geojson(datasource text)
   RETURNS json AS
   $$
   DECLARE
       sqltext text;
       ajson json;
   BEGIN
       sqltext:= format('
           SELECT jsonb_build_object(
               ''type'',  ''FeatureCollection'',
               ''features'', jsonb_agg(features.feature)
           )::json
           FROM (
             SELECT jsonb_build_object(
               ''type'',       ''Feature'',
               ''id'',         id,
               ''geometry'',   ST_AsGeoJSON(ST_Transform(geom, 4326))::jsonb,
               ''properties'', to_jsonb(inputs) - ''geom''
             ) AS feature
             FROM (
                 SELECT * FROM (%s) foo
             ) AS inputs
           ) AS features
       ', datasource);
       RAISE NOTICE 'SQL = %s', sqltext;
       EXECUTE sqltext INTO ajson;
       RETURN ajson;
   END;
   $$
   LANGUAGE 'plpgsql'
   IMMUTABLE STRICT;
   COMMENT ON FUNCTION query_to_geojson(text) IS 'Generate a valide GEOJSON from a given SQL query.';

   -- Create a query depending on the action, layer and feature and returns a GeoJSON.
   CREATE OR REPLACE FUNCTION lizmap_get_data(parameters json)
   RETURNS json AS
   $$
   DECLARE
       feature_id integer;
       layer_name text;
       layer_table text;
       layer_schema text;
       action_name text;
       sqltext text;
       datasource text;
       ajson json;
   BEGIN

       action_name:= parameters->>'action_name';
       feature_id:= (parameters->>'feature_id')::integer;
       layer_name:= parameters->>'layer_name';
       layer_schema:= parameters->>'layer_schema';
       layer_table:= parameters->>'layer_table';

       -- Action liztest
       -- Written here as an example
       -- Performs a buffer on the geometry
       IF action_name = 'liztest' THEN
           datasource:= format('
               SELECT
               %1$s AS id,
               ST_Buffer(geom, %4$s) AS geom
               FROM "%2$s"."%3$s"
               WHERE id = %1$s
           ',
           feature_id,
           layer_schema,
           layer_table,
           parameters->>'buffer_size'
           );
       ELSE
       -- Default : return geometry
           datasource:= format('
               SELECT
               %1$s AS id,
               geom
               FROM "%2$s"."%3$s"
               WHERE id = %1$s
           ',
           feature_id,
           layer_schema,
           layer_table
           );

       END IF;

       SELECT query_to_geojson(datasource)
       INTO ajson
       ;
       RETURN ajson;
   END;
   $$
   LANGUAGE 'plpgsql'
   IMMUTABLE STRICT;
   COMMENT ON FUNCTION lizmap_get_data(json) IS 'Generate a valide GEOJSON from an action described by a name, PostgreSQL schema and table name of the source data, a QGIS layer name, a feature id and additionnal options.';


The function ``lizmap_get_data(json)`` is provided here as an example. Since it is the **key entry point**, you need to adapt it to fit your needs.

You can use all the given parameters (action name, source data schema and table name, feature id, QGIS layer name) to create the appropriate query for your action(s), by using PostgreSQL ``IF THEN ELSIF ELSE`` clauses.
