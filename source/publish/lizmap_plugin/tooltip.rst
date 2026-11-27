.. include:: ../../substitutions.rst

Tooltip — Configure the tooltip for some layers
===============================================

.. contents::
   :depth: 3

Principle
---------

You can let the user activate map tooltips when hovering features by choosing a list of fields to display.

Prerequisites
-------------

.. include:: ../../shared/wfs_layer.rst

Configuring the tool
--------------------

..  image:: /images/interface-add-tooltip.jpg
   :align: center

- For setting a tooltip on a layer:

    1. .. include:: ../../shared/add_layer.rst
    2. Choose the layer.
    3. Select some fields to display in the tooltip.
    4. Optionally, choose to display the geometry.
    5. If you display the geometry, you can set the color.
    6. Optionally, check :guilabel:`Display layer features` to draw the features on the map with a symbology as
       close as possible to the **QGIS style** of the layer, for instance the icons of a point layer. The hovered
       feature is enlarged.

       .. note::
           The QGIS symbology is converted with the SLD standard, so the result is not always perfect.
           SVG and PNG files must be embedded in the symbology properties.

- .. include:: ../../shared/edit_layer.rst
- .. include:: ../../shared/remove_layer.rst
- .. include:: ../../shared/field_alias.rst
