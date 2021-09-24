.. include:: ../../substitutions.rst

Layer configuration
===================

.. contents::
   :depth: 3

These settings are in :menuselection:`Layer properties`.

.. _layer_qgis_server:

QGIS Server tab
---------------

In :menuselection:`Layer Properties --> QGIS Server`, you can set different settings for QGIS Server :

* :guilabel:`Short name` is a machine readable name for the layer.
* :guilabel:`dataUrl` is the URL to a HTML or PDF presenting the data. It can be a link to the open data portal webpage.

If the link is empty in :menuselection:`Lizmap --> Layers` dialog, the link in Lizmap will be automatically populated
by the Lizmap plugin from set in this tab.

You can use the |refresh_svg| button in Lizmap to pick this value.

.. _alias_on_fields:

Add a alias on a field
----------------------

Usually, the field names are defined without accent, spaces and can't be very long.
In :menuselection:`Layer Properties --> Attributes Form` and clicking on a field, you can add an alias.

This will be used to substitute the field name when possible for a more friendly name.

:menuselection:`Layer Properties --> Source Fields`, you can the list of alias defined on the layer.

.. _form:

Customize the edition form
--------------------------

In :menuselection:`Layer Properties --> Attributes Form` and clicking on a field, you can setup the form.

To set the editing tools for your layer fields:

  - In :menuselection:`Layer properties --> Attributes Form`.
  - By selecting first a field on left panel, select the :guilabel:`Widget type`:

    + To hide a field, choose :guilabel:`Hidden`. The user will not see the field in the form. There will be no content inserting. *Use it for the primary key*.
    + To add a read-only field, unchecked :guilabel:`Editable` checkbox.
    + Special case of the option :guilabel:`Value Relation`. You can use this option for a Lizmap map.
        For users to have access to information of the outer layer that contains the data, you must enable the publication of the layer as a WFS layer in :menuselection:`Project properties --> QGIS Server --> WFS`.

.. warning:: Lizmap Web Client does not know the "QT Designer UI file" for form generation. Therefore only use the :guilabel:`Autogenerate` mode or :guilabel:`Drag and drop` mode for editing layers.

.. note:: To make the field compulsory you have to define it as ``NOT NULL`` in the properties of the table, **in the database**, not in :guilabel:`QGIS --> Layer Properties`.

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

.. _edition-expressions:

Advanced form
^^^^^^^^^^^^^

.. note::
    To group fields in different tabs, follow QGIS documentation https://docs.qgis.org/latest/en/docs/user_manual/working_with_vector/vector_properties.html#the-drag-and-drop-designer.

Lizmap can reproduce several behavior configured in QGIS :

* **Control visibility by expression**. For example, you can toggle tab's visibility based on a checkbox state.

    For that, we can create a field named ``has_photo`` defined as a ``Checkbox`` and a ``photo`` tab having
    ``Control Visibility by Expression`` checked and ``"has_photo" = true OR "has_photo" = 't'`` as Expression.

* **Constraints defined by expression**.
    For example, you want to simply assert users correctly type a website URL beginning by `http` (of course,
    regex would be better but we keep it simple).

    For that, we can create a field named ``website`` defined as a ``Text Edit``, define ``Constraints`` with
    ``left( "website", 4) = 'http'`` as expression and ``Web site URL must start with 'http'`` as Expression description.

* **Filter expression for a Value Relation field**.
    For example, you want a field to automatically get the related
    value from another layer's field when drawing a point on the map. For that, we can create a field name
    ``quartier`` defined as a Value Relation to a ``quartiers`` layer and set ``intersects($geometry, @current_geometry)``
    as Filter expression. We can also check ``Not null`` and ``Enforce not null contraint`` to assert no NULL
    value can be set.

.. raw:: html

  <center>
    <video controls src="../../_static/videos/advanced_form.mp4"></video>
  </center>

.. _server_side_simplification:

Server side simplification
--------------------------

For PostGIS layers, you can enable server side simplification. This in :menuselection:`Layer properties --> Rendering` for each layers.
You can change the default behavior for next new layer in  This in :menuselection:`QGIS General properties --> Rendering`.
