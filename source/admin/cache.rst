.. _seed-cache:

=================================
Cache management as administrator
=================================

.. contents::
   :depth: 3

For a layer with server cache activated, Lizmap will keep the cache when the user pan and zoom on the map.
To have better performance, Lizmap Web Client can also automatically generate the tile cache on the server.

In some cases, it is desirable to remove the server cache, for example,
when the style has changed and the tiles need to be updated.
For this, some solutions are possible:

Remove all the cache by Lizmap repository
=========================================

In the administration interface, in the :guilabel:`Maps management` page,
for each repository, the administrator can delete the cache for all layers of all the projects
repository by clicking the button :guilabel:`Empty cache`.

Delete the cache, layer by layer, for each Lizmap project
=========================================================

When the administrator is connected and consults a Lizmap map, a **little red cross** is displayed on the
right of the name of each layer that is configured with server cache.
Clicking on the cross allows, after confirmation, to delete the server cache only for this layer in the QGIS project.

Only logged administrator sees these red crosses and has the right to delete the cache.

Use the console command for a whole project or layer
=========================================================

.. code-block:: bash

   # Go to the application folder
   cd /var/www/lizmap-web-client/
   
   # Command help
   # php lizmap/console.php wmts:cache:clean  repository project [layer] 

   # Clean the cache for a given project 
   php lizmap/console.php wmts:cache:clean montpellier montpellier

   # Clean the cache for a given layer
   php lizmap/console.php wmts:cache:clean montpellier montpellier bus



Configuring the caching system
==============================

In the :menuselection:`Administration -> Lizmap Configuration -> Cache`, you can configure the caching system which is
used.
You can choose between different kind of caching :

* Files
* Sqlite
* Redis (You would need a Redis server)

Seeding
=======

You can pre-generate the tiles for any layers of a QGIS project configured with server-side caching on.
You need to have full access on the server where Lizmap is installed and use a terminal to connect to it.
You also need to know the ids of Lizmap repositories and the code name of the project
(the QGIS project filename without the extension).

In this example, we will show commands to manage the tiles cache for the demo project ``Montpellier``, shipped with Lizmap Web Client.
We also assume that your Lizmap application is installed in the folder :file:`/var/www/lizmap-web-client/`.

.. code-block:: bash

   # Go to the application folder
   cd /var/www/lizmap-web-client/


It is important to know that Lizmap publish the cached layers in WMTS (Web Map Tiled Service). The following concepts are used as options of Lizmap tile cache seeder:

* **TileMatrixSet** - In Lizmap, this represents the projection code, for example `EPSG:3857` (Pseudo mercator).
* **TileMatrixMin** - This is the minimum zoom level.
* **TileMatrixMax** - This is the maximum zoom level.

.. warning::
    The zoom level is **not** a map scale, but the the zoom level. In Lizmap plugin, the project publisher can
    configure scales for the published project, for example the list : `100000, 50000, 25000, 10000`.
    The zoom level ID depends on some CRS and how you configured your Lizmap project.
    You can have a idea of the scale ID by typing `lizMap.map.getZoom()` in your webbrowser Javascript console when
    zooming on your map.

First you **must** get the cache capabilities of one project and some details on a specific layer.

.. code-block:: bash

   # Command help
   # php lizmap/console.php wmts:capabilities [-v] repository project [layer] [TileMatrixSet]

   # Get the capabilities for a given project published with Lizmap
   # and generate the cache about these capabilities.
   php lizmap/console.php wmts:capabilities montpellier montpellier

   # Get precisions about a specific layer
   php lizmap/console.php wmts:capabilities -v montpellier montpellier bus EPSG:3857
   # which will return
   For "bus" and "EPSG:4326" from TileMatrix 13 to 15
   For "bus" and "EPSG:900913" from TileMatrix 14 to 16
   For "bus" and "EPSG:3857" from TileMatrix 14 to 16


In this example, you see that the bus layer has 3 different TileMatrixSet, corresponding to the 3 different
spatial coordinate systems available for this project in Lizmap (configured in the :menuselection:`Project properties --> QGIS Server`).

.. note::
    If your layer name has some spaces, you need to use `""`.

It's important to generate the cache capabilities **before** generating the cache for a specific layer.
The cache capabilities is used in the next command. The next command might fail if the cache capabilities is not present.

Once you have a good knowledge of a layer, you can generate the cache for it:

.. code-block:: bash

   # Command help
   # php lizmap/console.php wmts:cache:seed [-v] [-f] repository project layer TileMatrixSet TileMatrixMin TileMatrixMax

   # Example
   php lizmap/console.php wmts:cache:seed -v -f montpellier montpellier bus EPSG:3857 12 14
   # Which will return:
   81 tiles to generate for "bus" "EPSG:3857" "14"
   81 tiles to generate for "bus" "EPSG:3857" between "12" and "14"
   Start generation
   ================
   Progression: 6%, 5 tiles generated on 81 tiles
   Progression: 12%, 10 tiles generated on 81 tiles
   Progression: 18%, 15 tiles generated on 81 tiles
   Progression: 24%, 20 tiles generated on 81 tiles
   Progression: 30%, 25 tiles generated on 81 tiles
   Progression: 37%, 30 tiles generated on 81 tiles
   Progression: 43%, 35 tiles generated on 81 tiles
   Progression: 49%, 40 tiles generated on 81 tiles
   Progression: 55%, 45 tiles generated on 81 tiles
   Progression: 61%, 50 tiles generated on 81 tiles
   Progression: 67%, 55 tiles generated on 81 tiles
   Progression: 74%, 60 tiles generated on 81 tiles
   Progression: 80%, 65 tiles generated on 81 tiles
   Progression: 86%, 70 tiles generated on 81 tiles
   Progression: 92%, 75 tiles generated on 81 tiles
   Progression: 98%, 80 tiles generated on 81 tiles
   ================
   End generation

After seeding, update rights on cache :

.. code-block:: bash

   lizmap/install/set_rights.sh www-data www-data
