.. include:: ../../substitutions.rst

Action in a popup
=================

.. contents::
   :depth: 3

This is a feature in |lizmap_3_4|.

Principle
---------

This module allows to add one or several **action buttons** in the **Lizmap popup**
displayed for a **PostgreSQL** object, which will **trigger a query** in the database
and return a **geometry** to display on the map.

It reads a **JSON configuration file** which must be placed **aside the QGIS project**
in the same directory. This file lists the **PostgreSQL actions** to be added in the **popup**
for one or many QGIS PostgreSQL vector layers.

..  image:: /images/publish-configuration-action-popup.gif
   :align: center

Configuring the tool
--------------------

* Each action is **characterized** by a ``layer id``, a ``name``, a ``title``, an ``icon``, some optional ``options``, ``style`` and ``callbacks``. A new ``confirm`` property can be used since |lizmap_3_5|
* A layer can have **one or several actions**
* You can have **one or several layers** with their own actions

Example of this JSON configuration file, name :file:`myproject.qgs.action` if the QGIS project file is named :file:`myproject.qgs`.
In this project, there is a vector layer called ``Points`` with the internal layer ID ``points_a7e8943b_7138_4788_a775_f94cbd0ad8b6``
(you can get the QGIS layer internal ID with the expression ``@layer_id``)

.. code-block:: json

   {
       "points_a7e8943b_7138_4788_a775_f94cbd0ad8b6": [
           {
               "name": "buffer_500",
               "title": "Buffer 500m around this object",
               "confirm": "Do you really want to show the buffer ?",
               "icon": "icon-leaf",
               "options": {
                   "buffer_size": 500,
                   "other_param": "yes",
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
                   {"method": "select", "layerId": "bati_1a016229_287a_4b5e_a4f7_a2080333f440"},
                   {"method": "redraw", "layerId": "bati_1a016229_287a_4b5e_a4f7_a2080333f440"}
               ]
           }
       ]
   }

The **JSON configuration** file lists the **QGIS layers** for which you want to declare actions.
Each layer is defined by its **QGIS layer ID**, for example here ``points_a7e8943b_7138_4788_a775_f94cbd0ad8b6``,
and for each ID, a list of objects describing the actions to allow.

Each **action** is an object defined by:

* a ``name`` which is the action identifier.
* a ``title`` which is used as a label in Lizmap interface
* an ``icon`` which is displayed on the action button ( See https://getbootstrap.com/2.3.2/base-css.html#icons )
* an optional ``confirm`` property, since |lizmap_3_5|, containing some text. If set, a confirmation dialog will be shown to the user to ask if the action should really be launched or not. Use it if the action can modify some data in your database.
* an ``options`` object, giving some additional parameters for this action. You can add any needed parameter.
* a ``style`` object allowing to configure the returned geometry style. It follows OpenLayers styling attributes.
* a ``callbacks`` object allows to trigger some actions after the generated geometry is returned. They are defined by a ``method`` name, which can at present be:

    -  ``zoom``: zoom to the returned geometry
    -  ``select``: select the features from a given layer intersecting the returned geometry. The target layer **QGIS internal ID** must be added in the ``layerId`` property. In the example, the features of the layer containing buildings, ID ``bati_1a016229_287a_4b5e_a4f7_a2080333f440`` will be selected
    -  ``redraw``: redraw (refresh) a given layer in the map. The target layer QGIS ID must be added in the ``layerId`` property.

Lizmap detects the presence of this configuration file, and adds the needed logic when the map loads. When the users clicks on an object of one of this layer in the map, the **popup panel** shows the feature data. At the top of each popup item, **a toolbar will show one button per each layer action**.
The action ``title`` will be displayed on hovering the action button.

Each button **triggers the corresponding action**, if it is not yet **active** (else it deactivates and erases the geometry):

* Lizmap backend checks if the action is well configured,
* creates the **PostgreSQL query** and execute it in the layer PostgreSQL database. (See example below)
* This query returns a **GeoJSON** which is then displayed on the map.
* If some **callbacks** have been configured, they are launched
* Since |lizmap_3_5|, A Lizmap **event** ``actionResultReceived`` is emitted with the returned data and action properties.

The **created PostgreSQL query** is built up by Lizmap web client and
uses the PostgreSQL function ``lizmap_get_data(json)``
which **must be created beforehand** in the PostgreSQL table database.
This function also uses a more generic function ``query_to_geojson(text)``
which transforms any PostgreSQL **query string** into a **GeoJSON output**.

Here is **an example** below of the query executed in the PostgreSQL database by Lizmap Web Client internally,
for the example configuration given above, when the users clicks on the button action :guilabel:`buffer_500`,
for the **feature** with id ``1`` of the **layer** ``Points`` corresponding to the **PostgreSQL table** ``test.points``:

.. code-block:: postgresql

   SELECT public.lizmap_get_data('{
       "layer_name":"points",
       "layer_schema":"test",
       "layer_table":"points",
       "feature_id":1,
       "action_name":"buffer_500",
       "buffer_size":500,
       "other_param": "yes"
   }') AS data;


You can see that Lizmap creates a JSON parameters with all needed information and run the PostgreSQL function ``lizmap_get_data(text)``.

You need to create this PostgreSQL function ``lizmap_get_data(text)`` which returns a valid GeoJSON text
with one single object in it.
The following SQL code is **an example** to help you create the needed functions.
Obviously, **you must adapt it to fit your needs**.

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

   COMMENT ON FUNCTION query_to_geojson(text) IS 'Generate a valid GEOJSON from a given SQL text query.';

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

       -- Action buffer_500
       -- Written here as an example
       -- Performs a buffer on the geometry
       IF action_name = 'buffer_500' THEN
           datasource:= format('
               SELECT
               %1$s AS id,
               ''The buffer '' || %4$s || ''m has been displayed in the map'' AS message,
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
               ''The geometry of the object have been displayed in the map'' AS message
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

   COMMENT ON FUNCTION lizmap_get_data(json) IS 'Generate a valid GeoJSON from an action described by a name, PostgreSQL schema and table name of the source data, a QGIS layer name, a feature id and additional options.';


* The function ``lizmap_get_data(json)`` is provided here as an example. Since it is the **key entry point**, you need to adapt it to fit your needs. It aims to **create a query for each action name**, dynamically created for the given parameters, and return a GeoJSON representation of the query result data. You should have **only one feature** returned: use aggregation if needed. In the example above, we use the ``format`` method to set the query text, and the function ``query_to_geojson`` to return the GeoJSON for this query.

* You can use all the given parameters (action name, source data schema and table name, feature id, QGIS layer name) to create the appropriate query for your action(s), by using the PostgreSQL ``IF THEN ELSIF ELSE`` clauses. See the content of the ``parameters`` variable in the example above, containing some of the JSON configuration file properties, and some properties of the QGIS layer:

  - the **action name** ``action_name``, for example ``buffer_500``. You should use a simple word with only letters, digits and ``_``,
  - QGIS **layer name** (as in QGIS legend): ``layer_name``, for example ``Points``,
  - the PostgreSQL table **schema** ``layer_schema`` and **table name** ``layer_table`` for this layer,
  - the object **feature id** ``feature_id``, which corresponds to the value of the **primary key** field for the popup object,
  - the other **properties** given in the JSON configuration file, in the ``options`` property, such as ``buffer_size`` which is ``500`` in the example

* The ``IF ELSE`` is used to do a different query, built in the ``datasource`` variable, by checking the **action name**

* If the return data contains a ``message`` field, such as shown in the example above, the text contained in this field will be **displayed in the map** in a message bubble.

* The **geometry** returned by the function **will be displayed on the map**.

* You could use your function to **edit some data** in your database, before returning a GeoJSON. To do so, you need to replace the ``IMMUTABLE`` property par ``VOLATILE``. Please **use it with care** !

Since Lizmap Web Client **triggers an event** ``actionResultReceived`` any time the user clicks on an action button, and data is returned (in the same time as the result geometry is drawn on the map), you could use your own Javascript code to add some logic after the result is shown.

.. seealso::
    Chapter :ref:`adding-javascript`

For example, here we just write in the browser console the content received:

.. code-block:: javascript

   lizMap.events.on({

       actionResultReceived: function(e) {
           // QGIS Layer id
           var layerId = e.layerId;
           console.log('Layer ID = ' + layerId);
           // Feature ID, which means the value of the primary key field
           var featureId = e.featureId;
           console.log('Feature ID = ' + featureId);
           // Action item with its name and other properties: name, title, options, styles, etc.
           var action = e.action;
           console.log('Action properties = ');
           console.log(action);
           // Features returned by the action
           var features = e.features;
           console.log('Returned object = ');
           console.log(features);
       }
   });

You could use these data as you like in your JS code.
