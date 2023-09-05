.. include:: ../../substitutions.rst
.. _fts-searches:

Spatial searching
=================

.. contents::
   :depth: 3

In the map options, you can activate and configure the address search bar, based on external web services (nominatim,
google or french IGN). See :ref:`lizmap-config-map` .
Additionally, you can add spatial searching capability to Lizmap. This means you will allow the users to search within
spatial data, such as countries, points of interests, etc. You have two ways to add searching capability in Lizmap:

* For |qgis_2| and |qgis_3|, you can create a table or view ``lizmap_search`` in your PostgreSQL database to store the
  search data for all your Lizmap projects.
* For |qgis_2| only, you can use the plugin ``QuickFinder`` to configure a data search per QGIS project.

.. _postgresql-lizmap-search:

PostgreSQL search
-----------------

When you have many projects and data, the best solution to provide searching capabilities is to set up a dedicated
relation (table or view) inside your database. It's possible to use a PostgreSQL database to store the search data.

Prerequisites
_____________

* A PostgreSQL database, accessible from Lizmap Web Client.
* PostgreSQL extensions activated in this database : ``unaccent`` and ``pg_trgm`` (for effective LIKE queries)
* A custom function ``f_unaccent`` which can be used in an index. See this
  `Stack Overflow post <https://stackoverflow.com/questions/11005036/does-postgresql-support-accent-insensitive-collations/11007216#11007216>`_ for explanation

.. code-block:: postgresql

   -- Add the extension pg_trgm
   CREATE EXTENSION IF NOT EXISTS pg_trgm;

   -- Add the extension unaccent, available with PostgreSQL contrib tools. This is needed to provide searches which are not sensitive to accentuated characters.
   CREATE EXTENSION IF NOT EXISTS unaccent;

   -- Add the f_unaccent function to be used in the index
   CREATE OR REPLACE FUNCTION public.f_unaccent(text)
   RETURNS text AS
   $func$
   SELECT public.unaccent('public.unaccent', $1)  -- schema-qualify function and dictionary
   $func$ LANGUAGE sql IMMUTABLE;


.. note::
    We choose to use the ``pg_trgm`` extension and this custom ``f_unaccent`` function instead of the Full Text Search
    (FTS) tool of PostgreSQL, to keep the tool as simple as possible and avoid the need to create FTS "vectors" in your
    search data.

.. tip::
    If the instance is hosted on `lizmap.com <https://lizmap.com>`_, read the documentation about one step on
    `lizmap_search <https://docs.lizmap.cloud/en/postgresql.html#about-lizmap-search>`_.

Create the lizmap_search table or view
______________________________________

The database admin must create a table, view or materialized view called ``lizmap_search``.
This relation must be accessible in the ``search_path`` (you can put it in the public schema,
or configure the ``search_path`` variable for the database or the user which connects to the database).

The relation ``lizmap_search`` must contain the following columns:

* ``item_layer`` (text). Name of the layer. For example "Countries"
* ``item_label`` (text). Label to display the results, which is the data to search among. Ex: "France" or "John Doe - Australia". You can build it from a concatenation of several fields values.
* ``item_project`` (text). List of Lizmap projects separated by commas. When set, the search will be done only for the specified Lizmap projects. The value can be ``NULL`` if you don't want to filter per project.
* ``item_filter`` (text). Username or group name. When given, the results will be filtered by authenticated user login and groups. For example, 'admins'. The value can be ``NULL`` if you don't want to filter per user.
* ``geom`` (geometry). We advise to store all the geometries with the same SRID.

Here is an example of SQL code you can use, to add data from two different spatial tables into lizmap_search (here as a materialized view to ease further maintenance)

.. code-block:: sql

   DROP MATERIALIZED VIEW IF EXISTS lizmap_search;
   CREATE MATERIALIZED VIEW lizmap_search AS
   SELECT
       'Commune' AS item_layer, -- name of the layer presented to the user
       concat(idu, ' - ', tex2) AS item_label, -- the search label is a concatenation between the 'Commune' code (idu) and its name (tex2)
       NULL AS item_filter, -- the data will be searchable for every Lizmap user
       NULL AS item_project, -- the data will be searchable for every Lizmap maps (published QGIS projects)
       geom -- geometry of the 'Commune'. You could also use a simplified version, for example: ST_Envelope(geom) AS geom
   FROM cadastre.geo_commune
   UNION ALL -- combine the data between the 'Commune' (above) and the 'Parcelles' (below) tables
   SELECT
       'Parcelles' AS item_layer,
       concat(code, ' - ', proprietaire) AS item_label,
       'admins' AS item_filter, -- only users in the admins Lizmap group will be able to search among the 'Parcelles'
       'cadastre,urban' AS item_project, -- the Parcelles will be available in search only for the cadastre.qgs and urban.qgs QGIS projects
       geom
   FROM cadastre.parcelle_info
   ;


Optimisation
____________

* You should use a table, or a materialized view, on which you can add indexes to speed up the search queries.

* We strongly advise you to add a trigram index on the unaccentuated ``item_label`` field, to speed up the search query:

.. code-block:: sql

   -- Create the index on the unaccentuated item_label column:
   DROP INDEX IF EXISTS lizmap_search_idx;
   CREATE INDEX lizmap_search_idx ON lizmap_search USING GIN (f_unaccent(item_label) gin_trgm_ops);

   -- You can refresh the materialized view at any time (for example in a cron job) with:
   REFRESH MATERIALIZED VIEW lizmap_search;

.. warning::
    At present, Lizmap PostgreSQL search cannot use 3D geometries, or geometries with Z or M values.
    You have to use the ``ST_Force2D(geom)`` function to convert geometries into 2D geometries.

Configure access
________________

Once this table (or view, or materialized view) is created in your database, you need to check that Lizmap can have a read access on it.

If your Lizmap instance uses PostgreSQL to store the users, groups and rights, a connection profile already exists for your database. Then you can just add the ``lizmap_search`` relation inside this database (in the ``public`` schema).

If not, or if you need to put the search data in another database (or connect with another PostgreSQL user), you need to add a new **database connection profile** in Lizmap configuration file :file:`lizmap/var/config/profiles.ini.php`.
The new profile is a new jdb prefixed section, called **jdb:search**. For example, add the following section (please replace the ``DATABASE_`` variables by the correct values):

.. code-block:: ini

   [jdb:search]
   driver="pgsql"
   database=DATABASE_NAME
   host=DATABASE_HOST
   user=DATABASE_USER
   password=DATABASE_PASSWORD
   ; search_path=DATABASE_SCHEMA_WITH_LIZMAP_SEARCH,public

You don't need to configure the :guilabel:`locate by layer` tool.
The link with Lizmap Web Client is done automatically if you can run the query below successfully in PgAdmin using the same credentials as the Lizmap application.
You **mustn't** specify the schema where the lizmap_search table is located. It **must** work without specifying the schema.

.. code-block:: sql

   SELECT * FROM lizmap_search LIMIT 1;

You can now use the default search bar in Lizmap which is located on top right corner.

.. image:: /images/interface-postgresql-search.jpg
   :align: center
   :width: 300

QuickFinder Plugin
------------------

.. warning:: This is for |qgis_2| only. This plugin has not been ported to |qgis_3|.

The purpose of this plugin is to provide fast searching among big datasets, searching in a qtfs file generated by QGIS Desktop.

Prerequisites
_____________

* You must have install at least the **7.x** version of **PHP** in your Lizmap server.

Configuration
_____________

Inside QGIS:

* install QuickFinder Plugin, for |qgis_2| only
* choose a layer(s), define the fields to search among, pick the geometry storage format (WKT or Extent) and store Full Text Searchs (FTS) vector into a file database (.qfts). The filename must be identical to the QGIS project filename. Ex: :file:`myproject.qfts` for a QGIS project stored as :file:`myproject.qgs`.

.. warning:: Only **WKT** or **Extent** formats for geometry storage are working, since binary format (WKB) can not be decoded by LWC.

Inside LWC:

* put the database file beside the QGIS project, use the Search tool (input) and zoom to the chosen feature.
