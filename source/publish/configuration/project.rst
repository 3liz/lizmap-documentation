Project configuration
=====================

.. contents::
   :depth: 3

These settings are in :menuselection:`Project --> Project properties` or :kbd:`CTRL+SHIFT+P`.

.. _publish_layer_wfs:

OGC Services Capabilities
-------------------------

In :menuselection:`Project properties --> QGIS Server --> Service capabilities`, you can setup some metadata about your project:

- The title which will be used by Lizmap.
- Other information such as organization, the owner of the publication, the abstract, etc

Publish a layer as WFS
----------------------

For many feature of Lizmap, it's necessary to publish your layer as WFS. It will be require when you are using the Lizmap QGIS plugin to activate some features.

Lizmap Web Client uses the **Web Feature Service** (WFS) to get data from a QGIS vector layer and display it in the web interface. This is why the first thing to do whenever you want to show a layer data in the web client is to **publish the vector layer through the WFS**.

- To do so, open the :menuselection:`Project properties --> QGIS Server --> WFS capabilities` and add the layer as "published" by checking the corresponding checkbox and save the project.
- You can also tune the number of decimals to decrease the size of data to be fetched from WFS (keep 8 only for a map published in degrees, and keep 1 for map projections in meters)
