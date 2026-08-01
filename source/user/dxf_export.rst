DXF export
==========

The DXF export feature allows you to export the current map view as a DXF file, which can be opened in CAD software such as AutoCAD or QGIS.

.. note:: This feature is only available if the map publisher has enabled it. Only layers with WFS capabilities enabled can be exported.

Exporting the current map view
------------------------------

#. Click on the *DXF export* button in the menu bar.
#. A dialog appears with the following options:

   - **Scale**: Choose the export scale. This controls the level of detail in the output.
   - **Symbology mode**: Select how layer styling is handled in the DXF file:

     + *Symbol layer*: Preserves the full complexity of the QGIS symbology. Each symbol layer of a feature is exported as a separate DXF entity. For example, a road styled with a thick black line and a thin white line on top (cased road) will produce two distinct DXF elements.
     + *Feature*: Each feature is exported as a single DXF entity. Complex multi-layer symbology is simplified to one representation per feature, which results in a simpler DXF file.
     + *None*: Exports geometries without any symbology information.

   - **Layers**: Select which layers to include in the export. Only WFS-enabled layers are available for selection.

#. Click *Export* to generate the DXF file. The file will be downloaded automatically with the naming format ``ProjectName_Timestamp.dxf``.

.. note:: The layer order in the exported DXF file is determined by the QGIS project configuration and cannot be changed from the web client.
