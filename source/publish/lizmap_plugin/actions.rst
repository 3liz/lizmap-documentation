.. include:: ../../substitutions.rst

Actions — Add some custom buttons triggering PostgreSQL queries
===============================================================

.. contents::
   :depth: 3

Principle
---------

This module allows to add one or several **actions** in web interface. The concept
has been inspired by
`QGIS actions <https://docs.qgis.org/latest/en/docs/user_manual/working_with_vector/vector_properties.html#actions-menu>`_,
which can be used to run scripts inside QGIS.

Example of a feature action:

..  image:: /images/publish-configuration-action-popup.gif
   :align: center


At present, the only engine for Lizmap actions is **PostgreSQL queries** (Python will not be
supported). You can use PostgreSQL and PostGIS power to add specific logic in your web map.

  .. warning::
    **Lizmap actions** are therefore different than **QGIS native actions** and are not compatible each other.

When the user clicks on an action button, a **query** is sent by Lizmap Web Client
to the **PostgreSQL database**, with the current context data (map extent, feature ID, etc.).

A specific function ``lizmap_get_data`` is called with these parameters, and returns
a **GeoJSON** response containing one or several features generated by the SQL query
for the given action.

Lizmap Web Client will then run some **callbacks** from this response:

* zoom or center to the returned geometry,
* select features of another layer intersecting the returned geometry,
* display a message, etc.

Three action **scopes** are supported :

* ``project`` : an action menu item is added on the left menu bar
  when the map has at least one project action. The new panel shows
  an action selector and a button to trigger the selected action.
* ``layer``: the action selector is shown in the layer **Informations** panel
  visible by clicking the (i) button right the the layer name.
* ``feature``: action buttons are added in the popup toolbar for the layer features,
  allowing to trigger an action specific to each feature.

.. tip::
    For the ``project`` scope, the default database is used (file :file:`profiles.ini.php` in the
    `configuration <../../install/configuration.html>`_ chapter.

Example action selector:

..  image:: /images/action-selector.png
   :align: center


Demonstration
-------------

You can check the demo about `fire hydrants on the demo website <https://demo.lizmap.com>`_.

Click on a fire hydrant and

* Either select buildings which are within 150m
* Or find the closest fire station

Prerequisites
-------------

* Some knowledge in ``SQL`` and ``JSON``
* To use the ``select`` callback, your layer must have the **selection** enabled for the layer. See :ref:`attribute_table`
* .. include:: ../../shared/wfs_layer.rst

Configuring the tool
--------------------

At present, the actions cannot be configured from Lizmap plugin in QGIS.
A specific **JSON configuration file** must be written and placed **aside the QGIS project**
in the same directory. This file lists the **PostgreSQL actions** to be added in the map.

.. warning::
    In |lizmap_3_7|, the JSON syntax has changed.

    If you use the old JSON syntax, you will have a warning in Lizmap, inviting you to migrate to a newer version of the
    syntax.


Each action is **characterized** by a ``name``, a ``title``, a ``scope``, ``layers``, an ``icon``, some optional ``options``,
  ``style``, ``callbacks`` and ``confirm`` property can be used.

* An action can be proposed for a list of ``layers``: QGIS layer IDs should be used in the ``layers`` array
* An action can have a list of ``callbacks``

Example of a JSON configuration file, name :file:`fire_hydrant_actions.qgs.action` if the QGIS project file is named
:file:`fire_hydrant_actions.qgs`. In this project, there is a vector layer called ``Fire hydrants`` with the internal
layer ID ``emergency_fire_hydrant_04132268_86fb_4d5e_a426_ce3133494091``.
You can get the QGIS layer internal ID with the QGIS expression ``@layer_id``.

.. code-block:: json

    [
        {
            "name": "buffer_150",
            "title": "Buildings in the fire hydrant area (150m)",
            "scope": "feature",
            "layers": [
                "emergency_fire_hydrant_04132268_86fb_4d5e_a426_ce3133494091"
            ],
            "confirm": "Do you want to select buildings within 150m from this fire hydrant ?",
            "icon": "icon-home",
            "options": {
                "buffer_size": 150,
                "other_param": "yes"
            },
            "style": {
                "fill-color": "rgba(255,255,255,0.4)",
                "stroke-color": "#3399CC",
                "stroke-width": 1.25,
                "circle-radius": 5,
                "circle-fill-color": "rgba(255,255,255,0.4)",
                "circle-stroke-width": 1.25,
                "circle-stroke-color": "#3399CC"
            },
            "callbacks": [
                {
                    "method": "zoom"
                },
                {
                    "method": "select",
                    "layerId": "building_90f7692a_0ae2_4a7d_91de_b63cddb92963"
                }
            ]
        },
        {
            "name": "closest_fire_station",
            "title": "Find the closest fire station from this fire hydrant",
            "scope": "feature",
            "layers": [
                "emergency_fire_hydrant_04132268_86fb_4d5e_a426_ce3133494091"
            ],
            "confirm": "Do you want to select the closest fire station from this fire hydrant ?",
            "icon": "icon-resize-small",
            "options": {},
            "style": {
                "stroke-color": "red",
                "stroke-opacity": 0.8,
                "stroke-width": 4
            },
            "callbacks": [
                {
                    "method": "zoom"
                },
                {
                    "method": "select",
                    "layerId": "stations_1a71d61f_cb99_4ac4_8bd4_86304af9be44"
                }
            ]
        }
    ]

The **JSON configuration** file lists the **declared actions**.

Each **action** is an object defined by:

* a ``name`` which is the action identifier.
* a ``title`` which is used as a label in Lizmap interface
* a ``scope`` which can be: ``project``, ``layer`` or ``feature``
* an ``icon`` which is displayed on the action button (See the `Bootstrap documentation <https://getbootstrap.com/2.3.2/base-css.html#icons>`_).
  An **SVG icon** can be used instead of a bootstrap icon as a background of the popup action buttons.
  Use a relative **media path** (:ref:`media`).
* an optional ``confirm`` property, containing some text. If set, a confirmation dialog will be shown to the user to ask
  if the action should really be launched or not. Use it if the action can modify some data in your database.
* an ``options`` object, giving some additional parameters for this action. You can add any needed parameters.
  Note that this parameters are hard coded and cannot be changed by the user.
* a ``style`` object allowing to configure the returned geometry style. It follows **OpenLayers** styling attributes.
* a ``callbacks`` object allows to trigger some actions after the generated geometry is returned.
  They are defined by a ``method`` name, which can at present be:

    -  ``zoom``: zoom to the returned geometry
    -  ``select``: select the features from a given layer intersecting the returned geometry.
       The target layer **QGIS internal ID** must be added in the ``layerId`` property.
       In the example, the features of the layer containing buildings,
       ID ``building_90f7692a_0ae2_4a7d_91de_b63cddb92963`` will be selected.
    -  ``redraw``: redraw (refresh) a given layer in the map. The target layer QGIS ID must be added in the ``layerId``
       property.

How Lizmap uses this configuration file to launch actions
---------------------------------------------------------

Lizmap detects the presence of this **configuration file**, and adds the needed logic when the map loads.

For example, for ``feature`` scoped actions, when the users clicks on an object
of one of the action layer in the map, the **popup panel** shows the feature data.
At the top of each popup item, **a toolbar shows one button per each layer action**.
The action ``title`` will be displayed on hovering the action button.

Each button **triggers the corresponding action**, if it is not yet **active**
(else it deactivates and erases the geometry in the map):

* Lizmap backend checks if the action is well configured,
* creates the **PostgreSQL query** ``SELECT public.lizmap_get_data(json)`` with the parameters
  written in JSON, and executes it in the layer PostgreSQL database. (See example below)
* This query returns a **GeoJSON** which is then displayed on the map.
* If some ``callbacks`` have been configured, they are launched (``selection``, ``zoom``, ``redraw``)
* A Lizmap **event** ``actionResultReceived`` is emitted with the returned data and action properties.
  This allow user-defined Javascript scripts to use the action results.

The **created PostgreSQL query** is built up by Lizmap Web Client and
uses the PostgreSQL function ``lizmap_get_data(json)``
which **must be created beforehand** in the PostgreSQL table database.
This function also uses a more generic function ``query_to_geojson(text)``
which transforms any PostgreSQL **query string** into a **GeoJSON output**.

Here is **an example** below of the query executed in the PostgreSQL database by Lizmap Web Client internally,

* for the example configuration given above,
* when the users clicks on the button action :guilabel:`buffer_150`,
* for the **feature** with id ``2592251664`` of the **layer** ``Fire hydrants``
* corresponding to the **PostgreSQL table** ``fire_hydrant_actions.emergency_fire_hydrant``:

.. code-block:: postgresql

   SELECT public.lizmap_get_data('{
       "lizmap_repository": "features",
       "lizmap_project": "fire_hydrant_actions",
       "action_name": "buffer_150",
       "action_scop": "feature",
       "layer_name": "Fire hydrant",
       "layer_schema": "fire_hydrant_actions",
       "layer_table": "emergency_fire_hydrant",
       "feature_id": 2592251664,
       "map_center": "POINT(3.4345918 43.63399141565576)",
       "map_extent": "POLYGON((3.429635077741169 43.63175113378633,3.439548522258832 43.63175113378633,3.439548522258832 43.63623161401291,3.429635077741169 43.63623161401291,3.429635077741169 43.63175113378633))",
       "wkt": "",
       "buffer_size":150,
       "other_param": "yes"
   }') AS data;


You can see that Lizmap creates a JSON parameter with all needed information
and run the PostgreSQL function ``lizmap_get_data(text)``.

The current **map extent** and **map center** are also sent as parameters
in **WKT format** (projection ``EPSG:4326``) and can be used in the PostgreSQL function.

Mandatory PostgreSQL functions
------------------------------

You need to create this PostgreSQL functions:

* ``query_to_geojson(text)`` which returns a valid GeoJSON text from any SELECT query
* ``lizmap_get_data(text)`` which is the "control tower" of Lizmap actions: it creates a specific
  query for each action based on the parameters and then run the query and returns the GeoJSON

The following SQL code is **an example** to help you create the needed functions.
Obviously, **you must adapt them to fit your needs**.

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
   CREATE OR REPLACE FUNCTION public.lizmap_get_data(parameters json)
   RETURNS json AS
   $$
   DECLARE
       feature_id varchar;
       layer_name text;
       layer_table text;
       layer_schema text;
       action_name text;
       sqltext text;
       datasource text;
       ajson json;
   BEGIN

       action_name:= parameters->>'action_name';
       feature_id:= (parameters->>'feature_id')::varchar;
       layer_name:= parameters->>'layer_name';
       layer_schema:= parameters->>'layer_schema';
       layer_table:= parameters->>'layer_table';

       -- Action buffer_150
       -- Performs a buffer on the geometry
       IF action_name = 'buffer_150' THEN
           datasource:= format('
               SELECT %1$s AS id,
               ''Buildings within 150m of the fire hydrant have been selected'' AS message,
               ST_Buffer(geom, 150) AS geom
               FROM "%2$s"."%3$s"
               WHERE osm_id = ''%1$s''
           ',
           feature_id,
           layer_schema,
           layer_table
           );
       ELSEIF action_name = 'closest_fire_station' THEN
           -- Draw a line to the closest fire station
           datasource:= format('
               WITH tmp_hydrant AS (
                   SELECT geom FROM fire_hydrant_actions.emergency_fire_hydrant WHERE osm_id = ''%1$s''
               )
               SELECT
                   id, name, ST_Distance(hydrant.geom, stations.geom),
                   ''The closest is :  '' || stations.name || '', '' || ST_Distance(hydrant.geom, stations.geom)::integer || ''m, flying air distance'' AS message,
                   ST_MakeLine(stations.geom, hydrant.geom) AS geom,
                   stations.id AS station_id
               FROM
                   fire_hydrant_actions.stations stations,
                   tmp_hydrant hydrant
               ORDER BY ST_Distance(hydrant.geom, stations.geom)
               LIMIT 1
           ',
           feature_id
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

   COMMENT ON FUNCTION public.lizmap_get_data(json) IS 'Generate a valid GeoJSON from an action described by a name, PostgreSQL schema and table name of the source data, a QGIS layer name, a feature id and additional options.';


* The function ``lizmap_get_data(json)`` is provided here as an example.
  Since it is the **key entry point**, you need to adapt it to fit your needs.
  It aims to **create a query for each action name**, dynamically created for the given parameters, and return a GeoJSON
  representation of the query result data. You should have **only one feature** returned: use aggregation if needed.
  In the example above, we use the ``format`` method to set the query text, and the function ``query_to_geojson`` to
  return the GeoJSON for this query.

* You can use all the **given parameters** (action name, source data schema and table name, feature id, QGIS layer name)
  to create the appropriate query for your action(s), by using the PostgreSQL ``IF THEN ELSIF ELSE`` clauses.
  See the content of the ``parameters`` **variable** in the example above, containing some of the JSON configuration file
  properties, and some properties of the QGIS layer:

  - Lizmap **repository** and **project** keys of the map: ``lizmap_repository`` & ``lizmap_project``
  - the action **name** ``action_name``, for example ``buffer_150``. You should use a simple word with only letters,
    digits and ``_``,
  - the action **scope** ``action_scope``, for example ``feature``,
  - QGIS **layer name** (as in QGIS legend): ``layer_name``, for example ``Fire hydrant``, only for ``feature`` actions,
  - the PostgreSQL table **schema** ``layer_schema`` and **table name** ``layer_table`` for the layer, only for
    ``feature`` and ``layer`` scoped actions
  - the object **feature id** ``feature_id``, which corresponds to the value of the **primary key** field for the popup
    object, only for ``feature`` actions,
  - the other **properties** given in the JSON configuration file, in the ``options`` property, such as ``buffer_size``
    which is ``150`` in the example
  - the **map center** ``map_center`` and **map extent** ``map_extent``

* The ``IF ELSE`` is used to do a different query, built in the ``datasource`` variable, by checking the **action name**

* If the return data contains a ``message`` field, such as shown in the example above, the text contained in this field
  will be **displayed in the map** in a message bubble.

* The **geometry** returned by the function **will be displayed on the map**.

* You could use your function to **edit some data** in your database, before returning a GeoJSON.
  To do so, you need to replace the ``IMMUTABLE`` property par ``VOLATILE``. Please **USE IT WITH CARE** !

Actions and user-defined JavaScript scripts
-------------------------------------------

Since Lizmap Web Client **triggers an event** ``actionResultReceived`` any time the user clicks on an action button,
and data is returned (in the same time as the result geometry is drawn on the map), you could use your own JavaScript
code to add some logic after the result is shown.

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

Actions can also be run from external JavaScript scripts:
you can use the actions **public methods** to **run an action**, or **reset** the active action:

.. code-block:: javascript


   // Run an action
   lizMap.mainLizmap.action.runLizmapAction(actionName, scope = 'feature', layerId = null, featureId = null, wkt = null);
   // Reset the action
   lizMap.mainLizmap.action.resetLizmapAction()

A **WKT** geometry, in ``EPSG:4326``, can also be sent as an additional parameter.
This is only possible when running the action with JavaScript.
This allows to send a geometry to be used by the PostgreSQL action function ``lizmap_get_data``
as a property of the ``parameters`` SQL variable.
(for example to get data from another table with geometries intersecting this passed WKT geometry)
