.. include:: ../../substitutions.rst

==============================
Prepare a QGIS project for Web
==============================

Create your project
===================

Add your data:

* Vector geographic data files

  * ESRI Shapefile
  * MapInfo TAB and MIF/MID
  * GeoJSON
  * etc

* RASTER geographic data files

  * GeoTIFF
  * Arc/Info ASCII Grid
  * netCDF
  * etc

* Geographic data base

  * PostgreSQL / PostGIS

    * When you create your connection to PostGIS, use the checkbox :guilabel:`Use estimated metadata`. Be careful, changing this checkbox after you have already added a layer doesn't change layers already loaded.

  * MSSQL spatial
  * Oracle locator / spatial

.. image:: /images/qgis-montpellier-project.jpg
   :align: center
   :width: 60%

Organize and manipulate the layers in the legend:

* *Add groups* with a right click in the empty part of the legend: *Add a new group*
* *Move* layers and groups with *drag-and-drop*
* *Rename* layers and groups with the :kbd:`F2` or the layer properties window
* Manipulate the rendering order:

  * with the *legend layer order*: the upper layers are rendered above the others.
  * by specifying *layer order* with the menu :menuselection:`View --> Panels --> Layer order`

Add a title to your project and save it in your working directory.

.. note:: If your layer has more than one style, the user will be able to switch between them through the button *Change layer style* at the top of the legend.

Set up your project for Web
===============================================================

Configure the coordinates reference system, CRS, of your project:

* Select the CRS of your Web map:

  * EPSG:3857 for Google Mercator
  * EPSG:2154 for Lambert 93
  * etc

* QGIS can reproject raster and vector data.

.. image:: /images/qgis-montpellier-project-crs.jpg
   :align: center
   :width: 60%

Configure the Web Geographics Services parameters with the *QGIS Server* tab:

* Set the title of your Web Geographics Services. This title is used in the Lizmap landing page.
* Add informations like your organization, the owner of the publication, the abstract, etc
* Set the maximum extent of your WMS service
* Restrict the CRSs list of your WMS service:

  * at least select the one used in your project
  * you can use the button *Used* to get all the layer CRS and the project one

* Exclude compositions and layers if data cannot be published in WMS
* Enable the layers you want to publish WFS and WCS

.. image:: /images/qgis-montpellier-project-ows.jpg
   :align: center
   :width: 60%

Check that the paths are saved *relative* in the general tab of the project properties window, access it with the menu :menuselection:`Project --> Project Properties` or :kbd:`CTRL+SHIFT+P`.

.. _layers-tab-metadata:

Configure your layers for the Web
=================================

In the window :menuselection:`Layer properties --> QGIS Server` allows you to configure a lot of information for Web Geographic Services:

* Provide a title, a description and keywords
* Specify the attribution to respect the data license
* Add the metadata record URL if it's available

.. image:: /images/qgis-montpellier-project-tram-layer-metadata.jpg
   :align: center
   :width: 60%

In the window :guilabel:`Rendering` tab, enable the :guilabel:`Simplify geometry` and the :guilabel:`Simplify on the provider side if possible` checkbox too.
Note this can be changed in your global settings for layers added later.
Read :ref:`server_side_simplification`.

Save your QGIS project
======================

.. warning::
    In |qgis_3|, it's possible to save your project in ``QGZ`` format or in database (PostGIS/Geopackage).
    Lizmap does not support these formats.
    You must save your project as ``QGS`` extension by doing :menuselection:`Project --> Save as... --> QGIS file` and not choosing ``QGZ``.

You should save your project as ``QGS`` file on your filesystem before opening the Lizmap plugin in the next step.
