Project configuration
=====================

.. contents::
   :depth: 3

These settings are in :menuselection:`Project --> Project properties` or :kbd:`CTRL+SHIFT+P`.

QGIS Server
^^^^^^^^^^^

:menuselection:`Project --> Project properties --> QGIS Server`

Services Capabilities
---------------------

In :menuselection:`Service capabilities`, you can setup some metadata about your
project:

* :guilabel:`Title`, the main title which will be displayed in the landing page. Use a human title with space and accents.
* :guilabel:`Abstract`, a fully written paragraph for the description. HTML is supported.
* :guilabel:`Keywords`, some keywords separated by a comma. This will be used by the search bar.
* Etc

WMS
---

* The extent will be used to set the maximum extent where the user can pan the map on Lizmap
* :guilabel:`Add geometry to feature info response` to be able to show the geometry when display the popup or to use the
  geometry in an expression in the QGIS maptip.

.. _publish_layer_wfs:

WFS/OAPI
--------

Lizmap Web Client uses the **Web Feature Service** (WFS) to get data from a QGIS vector layer and display it in the
web interface. This is why the first thing to do whenever you want to show a layer data in the web client is to
**publish the vector layer through the WFS**.

#. Open the :menuselection:`Project properties --> QGIS Server --> WFS/OAPI`
#. For a given layer:
    #. Use the checkbox :guilabel:`Published`
    #. If your layer is in meters, decrease the number of decimals, to reduce the size of data to be fetched from WFS.
       Two decimals might be enough if your layer is in meters.
#. Save the project