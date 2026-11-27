Permalink
=========

.. contents::
   :depth: 3

.. _short-permalink:

Short permalink
---------------

By default, the permalink contains all the map parameters (extent, layers, styles, opacities…) in plain text in the
URL.

In :menuselection:`Lizmap plugin --> Map options --> Generic options`, the checkbox
:guilabel:`Enable short link permalink` replaces these parameters by a short code, for instance
``#permalink=AbCdEfGh1234``. The parameters are stored on the server, in a ``permalink`` table of the Lizmap database.
The same parameters always give the same code.

A short permalink keeps:

* the map extent,
* the visible layers, their styles and opacities,
* the checked items of the layer symbology, for instance the categories of a categorized style,
* the selected base layer.

In the :guilabel:`Permalink` panel of Lizmap Web Client, the user can:

* create a new permalink,
* copy it to the clipboard or share it,
* see the list of the recent permalinks, stored in the web browser, and clear this list.

Administrators can see and clean the stored permalinks in the :guilabel:`Permalinks` page of the administration
interface, read :ref:`admin-permalinks`.

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