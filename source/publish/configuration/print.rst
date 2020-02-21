Printing
========

Area defined by the user on the fly in Lizmap
---------------------------------------------

To add print capabilities in the online map, you have to enable the printing tool in the plugin *Map* tab (:ref:`lizmap-config-map`) and the QGIS project has at least one print composition without having atlas enabled.

The print composition must contain **at least one map** without atlas enabled.

You can add :

* An image to North arrow
* An image for the logo of your organization
* A legend that will be fixed for all printing
* A scale, preferably digital for display
* A location map, a map for which you have enabled and configured the function of *Overview*
* Labels
* Since QGIS 3, you can use QGIS expressions, in your labels for instance. You can create automatic source label according to visible layers following this example https://docs.qgis.org/3.4/en/docs/user_manual/print_composer/composer_items/composer_label.html#id4 on the QGIS Documentation.

You can allow the user to modify the contents of certain labels (title, description, comment, etc).
To do this, you need to add a identifier to your label in the composer. Lizmap will automatically ask you in the webbrowser to fill each fields.
If your label is pre-populated in QGIS, the field will be pre-populated too in the webbrowser. If you check 'Render as HTML' for your label in QGIS, you will have a multiline label in Lizmap.

The preview in Lizmap will be similar to this screenshot. The red rectangle is the area that the user can define in the webbrowser and the user can also set the map description and the map title.

.. image:: /images/print_user_params.jpg
   :align: center
   :width: 800

Finally the print function will be based on the map scales that you set in the plugin *Map* (:ref:`lizmap-config-map`).

.. note:: It is possible to exclude printing compositions for the web. For example, if the QGIS project contains 4 compositions, the project administrator can exclude 2 compositions in the *QGIS project properties*, *QGIS server* tab. So only the published compositions will be presented in Lizmap.

.. image:: /images/exclude_layout.jpg
   :align: center
   :width: 600

Layout with an atlas when using a popup
---------------------------------------

Using the atlas-print https://github.com/3liz/qgis-atlasprint plugin on QGIS Server, it's possible to automatically add a link to the PDF.

* Install the AtlasPrint plugin on the server
* Enable an atlas layout on a layer
* Enable :ref:`popup` on the same layer

A link will be displayed automatically at the bottom of the popup. It's not possible to let the user fill some inputs. These PDF are linked to a feature due to the atlas.

.. _print-external-baselayer:

Allow printing of external baselayers
-------------------------------------

The Lizmap plugin :guilabel:`Baselayers` tab allows you to select and add external baselayers (:ref:`lizmap-config-baselayers`).
These external baselayers are not part of the QGIS project, default print function does not integrate them.

To overcome this lack Lizmap offers an easy way to print a group or layer instead of the external baselayer.
To be able to print a layer which is visible in Lizmap Web Client only:

* You need to add the equivalent layer in the QGIS project.
* You might need to hide it from the legend, see :ref:`hide-layers`.
* Rename the layer to one of these names:

* ``osm-mapnik`` for OpenStreetMap
* ``osm-stamen-toner`` for OSM Stamen Toner
* ``osm-cyclemap`` for OSM CycleMap
* ``google-satellite`` for Google Satellite
* ``google-hybrid`` for Google Hybrid
* ``google-terrain`` for Google Terrain
* ``google-street`` for Google Streets
* ``bing-road`` for Bing Road
* ``bing-aerial`` for Bing Aerial
* ``bing-hybrid`` for Bing Hybrid
* ``ign-scan`` for IGN Scan
* ``ign-plan`` for IGN Plan
* ``ign-photo`` for IGN Photos
* ``ign-cadastre`` for IGN Cadastre


.. note:: The use of this method must be in compliance with the licensing of external baselayers used (:ref:`lizmap-config-baselayers`).

.. warning::
    If it's not working, check that your server is able to access to the internet. These base layers are provided online only.
    Some proxy or firewalls might block some requests to the internet. If your server is behind a proxy, check that QGIS Server is configured
    with the proxy settings (using the file :file:`QGIS3.ini` and the section ``[proxy]``).

To add these layers, you can use existing WMS/WMTS services, XYZ providers (with QuickMapServices), local files...

For OpenStreetMap baselayers, it is possible to use an XML file for GDAL to exploit the OpenStreetMap tile services. Its use is described in the GDAL documentation https://gdal.org/frmt_wms.html or in this blog post https://www.3liz.com/blog/rldhont/index.php?post/2012/07/17/OpenStreetMap-Tiles-in-QGIS (beware, EPSG code should be 3857).
