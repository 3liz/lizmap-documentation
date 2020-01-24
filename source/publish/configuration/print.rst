Printing
========

Area defined by the user on the fly in Lizmap
---------------------------------------------

To add print capabilities in the online map, you have to enable the printing tool in the plugin *Map* tab (:ref:`lizmap-config-map`) and the QGIS project has at least one print composition.

The print composition must contain **at least one map**.

you can add :

* an image to North arrow
* an image for the logo of your organization
* a legend that will be fixed for all printing (before version 2.6)
* a scale, preferably digital for display
* a location map, a map for which you have enabled and configured the function of *Overview*
* labels

You can allow the user to modify the contents of certain labels (title, description, comment, etc).
To do this you need to add a identifier to your label in the composer. Lizmap will automatically ask you in the webbrowser to fill each fields.
If your label is pre-populated in QGIS, the field will be pre-populated too in the webbrowser. If you check 'Render as HTML' for your label in QGIS, you will have a multiline label in Lizmap.

Finally the print function will be based on the map scales that you set in the plugin *Map* (:ref:`lizmap-config-map`).

.. note:: It is possible to exclude printing compositions for the web. For example, if the QGIS project contains 4 compositions, the project administrator can exclude 2 compositions in the *QGIS project properties*, *QGIS server* tab. So only the published compositions will be presented in Lizmap.

Layout with an atlas when using a popup
---------------------------------------

Using the atlas-print plugin on QGIS Server, it's possible to automatically add a link to the PDF.

* Install the AtlasPrint plugin on the server
* Enable an atlas layout on a layer
* Enable :ref:`popup` on the same layer

A link will be displayed automatically at the bottom of the popup.

.. _print-external-baselayer:

Allow printing of external baselayers
-------------------------------------

The Lizmap plugin *Baselayers* tab allows you to select and add external baselayers (:ref:`lizmap-config-baselayers`). These external baselayers are not part of the QGIS project, default print function does not integrate them.

To overcome this lack Lizmap offers an easy way to print a group or layer instead of the external baselayer.

To add to printing a layer that replaces an external baselayer, simply add to the QGIS project a group or layer whose name is part of the following list:

* *osm-mapnik* for OpenStreetMap
* *osm-mapquest* for MapQuest OSM
* *osm-cyclemap* for OSM CycleMap
* *google-satellite* for Google Satellite
* *google-hybrid* for Google Hybrid
* *google-terrain* for Google Terrain
* *google-street* for Google Streets
* *bing-road* for Bing Road
* *bing-aerial* for Bing Aerial
* *bing-hybrid* for Bing Hybrid
* *ign-scan* for IGN Scan
* *ign-plan* for IGN Plan
* *ign-photo* for IGN Photos
* *ign-cadastre* for IGN Cadastre

and then add your layer(s) you want to print as base.

.. note:: The use of this method must be in compliance with the licensing of external baselayers used (:ref:`lizmap-config-baselayers`).

For OpenStreetMap baselayers, it is possible to use an XML file for GDAL to exploit the OpenStreetMap tile services. Its use is described in the GDAL documentation https://www.gdal.org/frmt_wms.html or in this blog post https://www.3liz.com/blog/rldhont/index.php?post/2012/07/17/OpenStreetMap-Tiles-in-QGIS (beware, EPSG code should be 3857).

By cons, if this layer has to replace an external baselayer, it must be accessible to QGIS-Server but should not be accessible to the user in Lizmap Web Client. So it must be hidden. See chapter :ref:`hide-layers`.