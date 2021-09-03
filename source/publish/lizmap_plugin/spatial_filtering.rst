.. include:: ../../substitutions.rst

Filtering by polygon
====================

.. contents::
   :depth: 3

Principle
---------

In this panel, we can:

* configure a polygon layer to use for spatial filtering
* configure layers which must be filtered by the filtering layer

Prerequisites
-------------

This is a feature in |lizmap_3_5|.

The Lizmap plugin in QGIS Server **must** be installed with at least **Lizmap QGIS plugin 3.6**.
Otherwise, the filter won't work and all data will be visible.

Configuring the tool
--------------------

..  image:: /images/interface-filter-by-polygon.jpg
   :align: center

1. Choose the polygon layer used for filtering
2. Choose the field in this layer which has Lizmap groups, separated by a comma.
3. Add a layer to filter to this tool:

    1. .. include:: ../../shared/add_layer.rst
    2. Choose the layer to filter
    3. Choose the primary key of the layer
    4. Choose if the filtering if for both visualisation and editing or only editing
    5. Choose either **intersection** or **contain** spatial relationship.

- .. include:: ../../shared/edit_layer.rst
- .. include:: ../../shared/remove_layer.rst

For your information, performance will be better when using PostgreSQL layers : either filtering or filtered
layers or both.
