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

In :menuselection:`Layer Properties --> Attribute Form` and clicking on a field, you can setup the form.

To set the editing tools for your layer fields:

  - In :menuselection:`Layer properties --> Attributes Form`.
  - By selecting first a field on left panel, select the :guilabel:`Widget type`:

    + To hide a field, choose :guilabel:`Hidden`. The user will not see the field in the form. There will be no content inserting. *Use it for the primary key*.
    + To add a read-only field, unchecked :guilabel:`Editable` checkbox.
    + Special case of the option :guilabel:`Value Relation`. You can use this option for a Lizmap map.
        For users to have access to information of the outer layer that contains the data, you must enable the publication of the layer as a WFS layer in :menuselection:`Project properties --> QGIS Server --> WFS`.

.. warning:: Lizmap Web Client does not know the "QT Designer UI file" for form generation. Therefore only use the :guilabel:`Autogenerate` mode or :guilabel:`Drag and drop` mode for editing layers.

.. note::
    All the editing tools are not yet managed by Lizmap Web Client. Only the following tools are supported:

        * Text edit
        * Classification
        * Range
        * Value Map
        * Hidden
        * Check Box
        * Date/Time
        * Value Relation
        * Relation Reference

    If the tool is not supported, the web form displays a text input field.

.. note:: To make the field compulsory you have to define it as ``NOT NULL`` in the properties of the table, at the database level.

.. _server_side_simplification:

Server side simplification
--------------------------

For PostGIS layers, you can enable server side simplification. This in :menuselection:`Layer properties --> Rendering` for each layers.
You can change the default behavior for next new layer in  This in :menuselection:`QGIS General properties --> Rendering`.
