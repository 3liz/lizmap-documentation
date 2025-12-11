
Attributes Form
===============

.. contents::
   :depth: 3


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

    + To hide a field, choose :guilabel:`Hidden`. The user will not see the field in the form. There will be no content
      inserting. *Use it for the primary key*.
    + To add a read-only field, unchecked :guilabel:`Editable` checkbox.
    + Special case of the option :guilabel:`Value Relation`. You can use this option for a Lizmap map.
      For users to have access to information of the outer layer that contains the data, you must enable the publication
      of the layer as a WFS layer in :menuselection:`Project properties --> QGIS Server --> WFS`.

.. warning::
    Lizmap Web Client does not know the "QT Designer UI file" for form generation. Therefore only use the
    :guilabel:`Autogenerate` mode or :guilabel:`Drag and drop` mode for editing layers.

.. note::
    To make the field compulsory you have to define it as ``NOT NULL`` in the properties of the table,
    **in the database**, not in :guilabel:`QGIS --> Layer Properties`.

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
    To group fields in different tabs, follow the
    `QGIS documentation about the drag and drop form <https://docs.qgis.org/latest/en/docs/user_manual/working_with_vector/vector_properties.html#the-drag-and-drop-designer>`_.

Lizmap can reproduce several behavior configured in QGIS :

* **Control visibility by expression**.
    For example, you can toggle tab's visibility based on a checkbox state.

      #. Create a field named ``has_photo`` defined as a :guilabel:`Checkbox` widget
      #. Create a ``photo`` tab having:

        * :guilabel:`Control Visibility by Expression` checked
        * :guilabel:`Expression` with ``"has_photo" = true OR "has_photo" = 't'``

* **Constraints defined by expression**.
    For example, you want to simply assert users correctly type a website URL beginning by ``http`` (of course, a
    `regular expression <https://regexr.com/>`_ would be better but we keep it simple).

      #. Create a field named ``website`` defined as a :guilabel:`Text Edit` widget
      #. Define the :guilabel:`Constraints`

        * :guilabel:`Expression` with ``left( "website", 4) = 'http'``
        * :guilabel:`Expression description` with ``Web site URL must start with 'http'``

* **Filter expression for a Value Relation field**.
    For example, you want a field to automatically get the related value from another layer's field when drawing a point
    on the map.

       #. Create a field name ``quartier`` (neighbourhood in French) defined as a :guilabel:`Value Relation` widget
       #. Set the parent layer to another layer ``quartiers``
       #. Set :guilabel:`Filter expression` with ``intersects($geometry, @current_geometry)``
       #. We can also check :guilabel:`Not null` and :guilabel:`Enforce not null contraint` to assert no NULL value can
          be set.

.. raw:: html

  <center>
    <video controls src="../../_static/videos/advanced_form.mp4"></video>
  </center>


.. tip::
    As shown in the video above, it's not possible anymore, natively, to have the combobox showing the area clicked
    automatically after the click on the map. The combobox has an empty value as a first item but has still a single
    value in the dropdown menu with the name of the neighbourhood clicked on the map.
