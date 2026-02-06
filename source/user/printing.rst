Printing
========

The print feature is available in the Lizmap menu bar. It depends on the number of print compositions published by the map publisher.

.. image:: /images/user-guide-14-print-menu.jpg
   :align: center
   :scale: 80%

Once the feature activated, a print area with the form of the composition is displayed on the map. Use this area to define the area to be printed. You can move it.

.. image:: /images/user-guide-15-print-zone.jpg
   :align: center
   :scale: 80%

On the left, above the panel layer management, you can select the scale of printing.

.. image:: /images/user-guide-16-print-scale.jpg
   :align: center
   :scale: 80%

Depending on the configuration of the printing composition, you can have the possibility to enter your own text.

.. image:: /images/user-guide-17-print-input.jpg
   :align: center
   :scale: 80%

To begin building the print file, you can click on *Print*. You will get a PDF file with the layout defined by the map publisher.

.. image:: /images/user-guide-18-print-result.jpg
   :align: center
   :scale: 80%

Atlas printing
--------------

When the map publisher has configured atlas print layouts for a layer, you can generate a PDF for individual features or a selection of features.

Atlas printing from the popup
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

When you click on a feature on the map and its popup appears, a print link is available if an atlas layout has been configured for this layer. Clicking the link generates a PDF for that single feature.

See :ref:`print-layout-atlas` for more details on how this is configured.

Atlas printing from the attribute table
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You can also print an atlas PDF for multiple features at once from the attribute table.

#. Open the attribute table for a layer that has atlas layouts configured.
#. Select one or more features using the selection tools (click the *Select* button on each row, or use the search and *Select searched lines* button).
#. Click the *Atlas* button in the attribute table toolbar. If the layer has multiple atlas layouts configured, a dropdown menu lets you choose which layout to use.
#. A PDF file is generated containing all selected features as an atlas. The file is downloaded automatically.

The PDF filename is derived from the atlas filename expression configured in the QGIS print layout. For a single feature, the filename evaluates the expression with that feature's attributes (e.g. ``Commune_Paris.pdf``). When multiple features are selected, a fallback name in the format ``ProjectName_LayoutName.pdf`` is used.

.. note:: The *Atlas* button is only visible in the attribute table toolbar for layers that have at least one atlas print layout configured by the map publisher.
