.. include:: ../../substitutions.rst

Legend
======

Groups
------

You can create groups in your legend. Lizmap will use them too in the web interface.

If you want to collapse some groups by default, you need to use a JavaScript snippet, see :ref:`adding-javascript`.


Theme switcher
--------------

This is a feature in |lizmap_3_4|.

Lizmap allows you to display and switch between themes configured in QGIS.
To create your themes, follow QGIS documentation https://docs.qgis.org/3.4/en/docs/user_manual/introduction/general_tools.html#configuring-map-themes.


.. _hide-layers:

Masking individual layers
-------------------------

You can exclude layers of your publication with the :guilabel:`QGIS Server` tab of the :guilabel:`QGIS project properties`.
In this case the layers will not be available in Lizmap **at all**. With this method, you cannot use a layer in the locate by layer
function and not display in the map.

To overcome this lack, Lizmap offers two simple ways to not display some layers only in the legend :

* Either create a group in your legend called ``hidden`` and put your layer into this group. This group (and its layers) won't be displayed in the Lizmap legend.
* Or use the check box :guilabel:`Hide in legend` in :menuselection:`Lizmap --> Layers` for the specific layer.

This feature can be used for:

* hide a layer used in the locate by layer (:ref:`locate-by-layer`)
* hide a simple layer for adding data rendered with a view
* hide a layer for printing (:ref:`print-external-baselayer`)

.. _overview-map:

Create an overview map
----------------------

To add an **overview map**, or location map, in the Lizmap's map, you must:

* Create an independent group in the QGIS project called ``Overview`` (with the 1st letter capitalized)
* **Add layers**, for example a layer of municipalities, a lighter terrain base layer, etc.

All layers and groups in the *Overview* group will **not be shown in the Lizmap's map legend**. They are drawn only in the Overview map.

It is advisable to use:

* **light and simplified** (if necessary) vector layers
* use a **suitable symbology**: small strokes and simple or hidden labels

.. note::
    The location map will use the extent of the WMS Capabilities, :menuselection:`Project Properties -> QGIS Server -> WMS`.

Here is an example of use:

.. image:: /images/features-overview.jpg
   :align: center
   :width: 60%
