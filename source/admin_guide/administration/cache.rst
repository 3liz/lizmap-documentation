===============================================================
Cache management as administrator
===============================================================

Lizmap Web Client can automatically generate a tile cache by the server as and when users access maps. In some cases it is desirable to remove the server cache, for example, when the style changes have been made for some spatial layers published in Lizmap Web Client. For this, two solutions are possible:

Remove all the cache by Lizmap repository
===================================================

In the administration interface, The **Lizmap configuration** menu lists configured *Lizmap repository*. For each repository, the administrator can delete the cache for all layers of all the projects repository by clicking the button **Empty cache**.

Delete the cache, layer by layer, for each Lizmap project
==============================================================

When the administrator is connected and consults a Lizmap map, a **little red cross** is displayed to the right of the name of each layer that is configured to be server cached. Clicking on the cross allows, after confirmation, delete the server cache only for this layer of the QGIS project. Only logged administrator sees these red crosses and has the right to start the delete.


Seeding
===========

You can pre-generate the tiles for any layers of a QGIS project configured with server-side caching on. To do so, you need to have full access on the server where Lizmap is installed, and use a terminal to connect to it. You also need to know the ids of Lizmap repositories, and the code name of the project ( the QGIS project filename without the extension ).

In this example, we will show commands to manage the tiles cache for the demo project Montpellier, shiped with Lizmap Web Client. We also assume that your Lizmap application is installed in the folder /var/www/lizmap-web-client/ .


.. code-block:: bash

   # Go to the application folder
   cd /var/www/lizmap-web-client/


It is important to know that Lizmap publish the cached layers in WMTS ( Web Map Tiled Service). The following concepts are used as options of Lizmap tile cache seeder:

* **TileMatrixSet** - In Lizmap, this represents the projection code, for exampe *EPSG:3857* ( Pseudo mercator )
* **TileMatrixMin** - This is the minimum zoom level . This is not a map scale, but a ID of the zoom level. In Lizmap plugin, the project publisher can configure scales for the published project. For example the list : *100000, 50000, 25000, 10000* .
* **TileMatrixMax** - This is the maximum zoom level


First you can get the cache capabilities of one project, and some details on a specific layer.

.. code-block:: bash

   # Command help
   # php lizmap/scripts/script.php lizmap~wmts:capabilities [-v] [-f] repository project [layer] [TileMatrixSet]

   # Get the cache capabilities for a given project published with Lizmap
   php lizmap/scripts/script.php lizmap~wmts:capabilities montpellier montpellier

   # Get precisions about a specific layer
   php lizmap/scripts/script.php lizmap~wmts:capabilities -v montpellier montpellier bus EPSG:3857
   # which will return
   For "bus" and "EPSG:4326" from TileMatrix 13 to 15
   For "bus" and "EPSG:900913" from TileMatrix 14 to 16
   For "bus" and "EPSG:3857" from TileMatrix 14 to 16


In this example, you see that the bus layer has 3 different TileMatrixSet , corresponding to the 3 different spatial coordinate systems available for this project in Lizmap publication ( configured in the *Project properties*, tab *OWS Server*. Once you have a good knowledge of a layer, you can generate the cache for it:

.. code-block:: bash

   # Command help
   # php lizmap/scripts/script.php lizmap~wmts:seeding [-v] [-f] repository project layer TileMatrixSet TileMatrixMin TileMatrixMax

   # Example
   php lizmap/scripts/script.php lizmap~wmts:seeding -v -f montpellier montpellier bus EPSG:3857 12 14
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

