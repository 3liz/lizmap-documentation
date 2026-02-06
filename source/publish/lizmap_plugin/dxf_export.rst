.. include:: ../../substitutions.rst

.. _dxf-export:

DXF export — Export map data to DXF
====================================

.. contents::
   :depth: 3

Principle
---------

The DXF export feature allows users to export the current map view as a DXF file via QGIS Server. This is useful for
users who need to work with the map data in CAD software such as AutoCAD.

The feature is disabled by default and must be explicitly enabled in the Lizmap plugin. You can control which user
groups are allowed to use the export and which layers can be exported.

Prerequisites
-------------

* The layers you want to make available for DXF export must have **WFS** capabilities enabled.
* .. include:: ../../shared/wfs_layer.rst

Configuring the tool
--------------------

In the Lizmap plugin, open the :guilabel:`DXF Export` panel:

1. Check :guilabel:`Allow DXF export` to enable the feature for the project.
2. Optionally, enter a comma-separated list of Lizmap group IDs in :guilabel:`Allowed groups` to restrict access.
   If left empty, all authenticated users can use the export (when the feature is enabled).
3. The layer table is automatically populated with all WFS-enabled layers. Use the checkboxes to enable or disable
   individual layers for DXF export.

Configuration storage
^^^^^^^^^^^^^^^^^^^^^

The configuration is stored in the ``.qgs.cfg`` file:

* ``options.dxfExportEnabled`` (boolean, default: ``false``) — enables or disables the DXF export feature.
* ``options.allowedGroups`` (string, comma-separated group IDs) — restricts access to specific Lizmap groups.
* ``dxfExport.layers[]`` (array of ``{layerId, enabled}`` objects) — controls which layers are available for export.

.. note::
    Existing projects without DXF export configuration will default to having the feature disabled, ensuring
    backward compatibility.
