.. include:: ../../substitutions.rst

.. _locate-by-layer:

Locate by layer — The locating tool
===================================

.. contents::
   :depth: 3

Principle
---------

The idea of this tool is to present to the Lizmap Web Client user a drop down list that gives the ability to zoom on one
or more spatial objects of the layer.

Use case
--------

Consider a spatial vector layer **districts** contained in the QGIS project. We choose to add these districts in the tool
*Locate by layer*, to allow Lizmap Web Client users to quickly position on one of the districts.

Once this layer added in the tool *Locate by layer*, a drop down list of the districts appears on the Lizmap Web interface.

When the Web map user selects one name in this list, the map will automatically refocuses on the selected district and
the district's geometry is displayed (optional).

Prerequisites
-------------

.. include:: ../../shared/wfs_layer.rst

.. warning::
    This tool is not designed for layers having a lot of features or a lot of complex geometries. The web browser
    will indeed have to download **all** features with vector geometries so it will make the loading the application
    slower. To reduce the loading time, you can reduce the decimals in the WFS settings for instance if your
    layer is in meters. For better performance if your layer is stored in PostGIS, use :ref:`postgresql-lizmap-search`.

Configuring the tool
--------------------

..  image:: /images/interface-add-locate-layer.jpg
   :align: center

To add a layer to this tool:

    1. .. include:: ../../shared/add_layer.rst
    2. **choose the layer** with the first dropdown from the list of the project vector layers
    3. then **the column that contains the label** you want to display in the dropdown list
    4. if you want to add pre-filter your data if a optional group by, use the :guilabel:`Optional group by` field.
    5. if you want the geometry of the related objects is also displayed on the map when the user selects an item from
       the list, then check the option *Display the geometry*
    6. If you set a value above 0, autocompletion will be used after this amount of characters while the user types.
       The classical combobox will be replaced by a editable text input.
    7. If Lizmap must trigger the filter on the layer. Only the selected feature will be visible on the map.

- .. include:: ../../shared/edit_layer.rst
- .. include:: ../../shared/remove_layer.rst
- .. include:: ../../shared/move_up_down_layer.rst

.. note::
    If you want to display the geometry, you need to active it in
    :menuselection:`QGIS Project Properties --> QGIS Server --> WMS`, then :guilabel:`Add geometry to the feature response`.

Hierarchical Lists
------------------

If we take the example of districts, it may be interesting to also provide to the user a *sub-districts* dropdown.
We wish that when the user chooses a district, the dropdown of sub-districts is automatically filtered to display only
the sub-districts of the chosen district.

For this, there are 2 methods:

* Either you have **2 separate vector layers**: one for districts and for sub-districts. You have to use a
  **field join** between the two layers to enable automatic filtering lists in Lizmap.
  :menuselection:`Layer properties --> Joins`,
  see the `QGIS documentation <https://docs.qgis.org/latest/en/docs/user_manual/working_with_vector/vector_properties.html#joins-properties>`_.
* Or you have **only 1 layer for sub-districts**. You need to set, in the plugin, a **group field**.
