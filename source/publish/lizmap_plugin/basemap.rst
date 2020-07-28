.. _lizmap-config-baselayers:

Base layers
===========

Principle
---------

It is often useful to separate base layers as a reference and thematic layers in a Web map.
In Lizmap, you can use groups or layers as base layers. It is also possible to use external services in the Web map.

The base layers are not part of the legend and are presented as a list.

.. note::
    If a single base layer is configured (project layer, external service or empty base layer), then Lizmap Web Client
    interface does not show the box *Base layers*, but the layer will be however visible below the other layers.

Configuring the tool
--------------------

The :guilabel:`Base layers` tab lets you add external services as base layer and an empty base layer.
The empty base layer will display thematic layers over the project background color.

.. image:: /images/interface-baselayers-tab.jpg
   :align: center
   :width: 80%

The available base layers
-------------------------

* *OpenStreetMap*, mapping project under free and open licenses:

  * OSM Mapnik: service available on openstreetmap.org

* *ThunderForest*, company using OSM data and providing tiles:
  * Open Cycle Map: OpenStreetMap cycling data including altitude information

* *Google*, requires compliance to use licence agreement:

  * Streets: the default Google Maps background layer
  * Satellite: the background map incorporating aerial and satellite images
  * Hybrid: the background map mixing streets and satellite
  * Terrain

* *Bing Map*, requires compliance with the Microsoft license agreement and therefore a key:

  * Streets: the default Bing Map background layer
  * Satellite: the background map incorporating aerial and satellite images
  * Hybrid: the background map mixing streets and satellite

* *IGN Géoportail*, requires compliance with the IGN license agreement and therefore a key:

  * Plan: The IGN rendering for the Web
  * Satellite: the background map incorporating IGN aerial and satellite images
  * Scan: the background map mixing the various IGN scan
  * Cadastre

The licenses are available at the following URLs:

* *OpenStreetMap*: https://wiki.openstreetmap.org/wiki/Tile_usage_policy
* *Google*: https://cloud.google.com/maps-platform/terms/
* *Bing*: https://www.microsoft.com/en-us/maps/product
* *IGN*: https://depot.ign.fr/geoportail/api/develop/tech-docs-js/fr/license.html

.. note::
    If you choose an external base layer, the map will be displayed in Google Mercator (EPSG: 3857 or EPSG: 900913),
    the scales are those of external services and QGIS-Server will perform on the fly reprojection.

It is therefore necessary to prepare the QGIS project accordingly.

The *Google Mercator* coordinate reference system must be added in the Web Services CRSs list with the *QGIS Server* tab in the *Project Properties* window.
For now, all the proposed base layers use the projection::

    EPSG:3857 ; Pseudo Mercator

Here are the approximate integer scales of the current external base layers::

    0   591659008
    1   295829504
    2   147914752
    3   73957376
    4   36978688
    5   18489344
    6   9244672
    7   4622336
    8   2311168
    9   1155584
    10  577792
    11  288896
    12  144448
    13  72224
    14  36112
    15  18056
    16  9028
    17  4514
    18  2257

External Lizmap layers
----------------------

This feature has been removed. It's replaced by the possibility of using the menu
:menuselection:`Layer --> Embed Layers and Groups`, and in the plugin *Layers* tab declare the parent project and the
Lizmap repository for the embed layers and groups. See :ref:`lizmap-cache-centralized`
