.. include:: ../../substitutions.rst

.. _lizmap-config-map:

Map options
===========

.. contents::
   :depth: 3

The tab :guilabel:`Map options` allows you to enable or disable basic Lizmap tools, choosing scales and the initial extent.

.. image:: /images/interface-map-tab.jpg
   :align: center
   :width: 80%

The generic options:

* hide the project in Lizmap Web Client:

  * if this option is checked, the project will be hidden in the Lizmap home page that shows thumbnails for all directories and project of the application. You can use this option to hide the project
  * the project will still be accessible for WMS or WFS clients based on directories rights
  * this feature is interesting  in the case of using this project as an external project for other ones.

The map tools:

* *Draw*: |lizmap_3_4|, enables some drawing tools.
* *Print*: enables the use of QGIS compositions for PDF generation map
* *Measure tools*: enables the measurement tools in the map (length, area, perimeter)
* *Zoom history*: enables the navigation buttons in the history of zoom and move in the map
* *Automatic geolocation*: enables the functions to use the HTML5 geolocation based on Wifi and/or GPS
* *Address search*: to add an address search engine that is based on one of these services:

  * Nominatim (OpenStreetMap)
  * Google
  * IGN France (Géoportail)
  * BAN (France)

The scales :

* a list of integer values separated by commas (and optional whitespace), eg: ``250000, 100000, 50000``.
* Lizmap also used these scales to restrict the application display between the minimum and maximum of these scales.
  This is why **it is mandatory to enter at least 2 scales** in the list.

.. warning::
    As soon as there is an external basemap published in **EPSG:3857** such as OSM, Google Maps..., the
    application will only use the minimum and maximum **scale** to the minimum and maximum **zoom level**.
    Intermediate **scale** that you might have defined won't be read, because there isn't a strict match
    between your **scale** and **zoom level** provided by external base map in **EPSG:3857**.

The initial map extent:

* a list of coordinates in the Reference Coordinate System map in the format: ``xmin, ymin, xmax, ymax``, setting the initial map extent
* the maximal map extent is specified in the *OWS server* tab of *Project Properties* window. The data will not be displayed if they are outside it
* by default, the initial extent is the maximal one.
