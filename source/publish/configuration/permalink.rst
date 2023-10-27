Permalink
=========

.. contents::
   :depth: 3

Zoom on an object when opening the map
--------------------------------------

Some URL parameters are available to be able to zoom in on one or more objects and display their popup:

* ``layer``, layer name in WFS and WMS services
* ``filter``, layer filter to initiate the zoom
* ``popup=true``, boolean to display the popup(s) of the filtered objects

The layer and filter parameters will be used for WFS and WMS type queries, so make sure that these are well compatible
with the 2 types of services.

For instance, we would like to reuse the map of Montpellier showing cadastral by
providing a customized link opening the popup from the :guilabel:`Park of Peyrou` in the city center.

This park has ``340172000BX0079`` for its unique ID in the field ``geo_parcelle``, layer ``parcelle``.

Therefore, we need to add in the URL above :

.. code-block:: ini

    layer=parcelle
    filter=%22geo_parcelle%22%20%3D%20%27340172000BX0079%27
    popup=true

It gives this final result :

https://demo.lizmap.com/lizmap/index.php/view/map?repository=miscellaneous&project=flatgeobuf&layer=parcelle&filter=%22geo_parcelle%22%20%3D%20%27340172000BX0079%27&popup=true

For your information, we can have the value of the filter with the help of the JavaScript console in your web browser :kbd:`F12` :

.. code-block:: javascript

    encodeURIComponent("\"geo_parcelle\" = '340172000BX0079'")`

.. tip::
    You should check **other** URL parameters which can be in the URL already. They can alter the behavior of the
    described feature, for instance ``bbox=``.