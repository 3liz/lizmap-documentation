Legend
======

: _hide-layers:

Masking individual layers
-------------------------

You can exclude layers of your publication with the *OWS Server* tab of the *QGIS project properties*. In this case the layers will not be available in Lizmap. With this method, you cannot use a layer in the locate by layer function and not display in the map.

To overcome this lack Lizmap offers a simple way to not display some layers.

Not to display one or more layers of QGIS project in the legend of the Web map, just put these layers in a group called "hidden". All the layers in this group will not be visible in the Web application.

This feature can be used for:

* hide a layer used in the locate by layer (:ref:`locate-by-layer`)
* hide a simple layer for adding data rendered with a view
* hide a layer for printing (:ref:`print-external-baselayer`)

Create an overview map
----------------------

To add an **overview map**, or location map, in the Lizmap's map, you must:

* Create an independent group in the QGIS project called **Overview** (with the 1st letter capitalized)
* **Add layers**, for example a layer of municipalities, a lighter terrain base layer, etc.

All layers and groups in the *Overview* group will **not be shown in the lizmap's map legend**. They are drawn only in the Overview map.

It is advisable to use:

* **light and simplified** (if necessary) vector layers
* use a **suitable symbology**: small strokes and simple or hidden labels

Here is an example of use:

.. image:: /images/features-overview.jpg
   :align: center
   :width: 60%
