Layer configuration
===================

These settings are in :menuselection:`Layer properties`.

.. _alias_on_fields:

Add a alias on a field
----------------------

Usually, the field names are defined without accent, spaces and can't be very long.
In :menuselection:`Layer Properties --> Attribute Forms` and clicking on a field, you can add an alias.

This will be used to substitute the field name when possible for a more friendly name.

:menuselection:`Layer Properties --> Source Fields`, you can the list of alias defined on the layer.

.. _form:

Customize the edition form
--------------------------

In :menuselection:`Layer Properties --> Attribute Forms` and clicking on a field, you can setup the form.

**Set the editing tools** for your layer fields

  - *Open the layer properties* by double-clicking on the layer name in the legend.
  - Go to *Fields* tab.
  - Select the *Editing tool* in the *Edit widget* column for each field of the layer:

    + To hide a field, choose *Hidden*. The user will not see the field in the form. There will be no content inserting. *Use it for the primary key*.
    + To add a read-only field, unchecked *Editable* checkbox.
    + Special case of the option *Value Relation*. You can use this option for a Lizmap map. For users to have access to information of the outer layer that contains the data, you must enable the publication of the layer as a WFS layer in the *OWS Server* tab of the QGIS *project properties*.
    + etc.

  - **QGIS 2 evolutions**:

    + To hide columns in the Lizmap popup, you must now uncheck the box in the *WMS* for each field to hide (this column is just after *Alias*)
    + Lizmap Web Client does not know the "QT Designer UI file" for form generation. Therefore only use the *Autogenerate* mode or *Drag and drop* mode for editing layers.

.. note:: All the editing tools are not yet managed by Lizmap Web Client. Only the following tools are supported: Text edit, Classification, Range, Value Map, Hidden, Check Box, Date/Time, Value Relation, Relation Reference. If the tool is not supported, the web form displays a text input field.

.. note:: To make the field compulsory you have to define it as `NOT NULL` in the properties of the table, at the database level.

.. _server_side_simplification:

Server side simplification
--------------------------

For PostGIS layers, you can enable server side simplification. This in :menuselection:`Layer properties --> Rendering` for each layers.
You can change the default behavior for next new layer in  This in :menuselection:`QGIS General properties --> Rendering`.
