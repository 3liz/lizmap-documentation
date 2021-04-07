.. _lizmap-config-baselayers:

Base layers
===========

.. contents::
   :depth: 3

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

Scale with external base layer
------------------------------

All these external base layer are provided only in **EPSG:3857 / Pseudo Mercator** from the provider.
The scale of such layer are **fixed** by the projection EPSG:3857.

.. warning::
    As a result, if you choose an external base layer, the project **will be displayed** in Google Mercator
    EPSG:3857. Therefore, if you have specified multiple scales in the Lizmap configuration, these
    intermediate scales **won't** be used. **Only** the **minimum** and **maximum** scale are used in this
    case. Read below about approximate scales.

.. image:: /images/interface-scale-3857.jpg
   :align: center
   :width: 80%

QGIS Server will perform **on the fly reprojection** for your data. It is therefore necessary to prepare the
QGIS project accordingly.

The *Google Mercator* coordinate reference system must be added in the Web Services CRSs list with the
:menuselection:`Project properties --> QGIS Server --> WMS`.

This is a list of a **very approximate** integer scale for a given zoom level for the **EPSG:3857**::

    0   500 000 000
    1   250 000 000
    2   150 000 000
    3   70 000 000
    4   35 000 000
    5   15 000 000
    6   10 000 000
    7   4 000 000
    8   2 000 000
    9   1 000 000
    10  500 000
    11  250 000
    12  150 000
    13  70 000
    14  35 000
    15  15 000
    16  8 000
    17  4 000
    18  2 000
    19  1 000
    20  500

.. warning::
    These scales are just a hint of the scale. It is not possible to have rounded scale like this with
    EPSG:3857.

Visit the OpenStreetMap website at the country level and check how the scale is changing while panning/zooming.

https://www.openstreetmap.org/#map=6/48.995/4.856

External Lizmap layers
----------------------

This feature has been removed. It's replaced by the possibility of using the menu
:menuselection:`Layer --> Embed Layers and Groups`, and in the plugin *Layers* tab declare the parent project and the
Lizmap repository for the embed layers and groups. See :ref:`lizmap-cache-centralized`
