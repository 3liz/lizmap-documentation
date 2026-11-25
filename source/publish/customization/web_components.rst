.. meta::
   :keywords: web component, html, popup, javascript, lizmap-features-table, lizmap-feature-button

.. _web-components:

Web components
==============

.. contents::
   :depth: 3

Principle
---------

Lizmap Web Client provides some **web components**: custom HTML elements, like ``<lizmap-features-table>``,
which are turned into interactive tools by Lizmap when they are displayed in the page.

Most of them are used internally by the Lizmap interface. This page only documents the components which are designed
to be used in your own content:

* :ref:`lizmap-features-table <web-component-features-table>`: a compact list of features of a layer,
  with access to their popup,
* :ref:`lizmap-feature-button <web-component-feature-button>`: a button to open the popup of a feature,
  to launch its edition, or to create a new feature.

They can be used:

* in a **popup**, mainly a :ref:`QGIS HTML Maptip popup <qgis-popup>`, where QGIS expressions can be used to build
  the attributes values from the feature fields,
* in your own **JavaScript** code, see :ref:`adding-javascript`, by creating the HTML element and adding it to the page.

.. note::
    The popup content is sanitized before being displayed: only the HTML elements whose name begins with ``lizmap-``
    are kept, with the attributes documented below and the ``data-*`` attributes.

.. _web-component-features-table:

lizmap-features-table
---------------------

*Since Lizmap Web Client 3.9*

Description
___________

This component displays a compact table of the features of a vector layer, filtered with an expression.

* The first column displays the **display name** of each feature, as configured in QGIS:
  :menuselection:`Layer properties --> Display --> Display name`.
* Additional columns can be added with ``<lizmap-field>`` child elements.
* If the popup is activated for the layer in the Lizmap plugin, a click on a line displays the feature popup
  below the table, with buttons to go to the previous or to the next feature, and to go back to the list.

.. tip::
    In the Lizmap plugin, the option :guilabel:`Display table of children (recommended)` of a layer popup
    automatically adds a ``lizmap-features-table`` for each child layer of the feature (see :ref:`popup`).
    You only need to write the element yourself to change its options or to display other features.

Attributes
__________

.. list-table::
   :header-rows: 1
   :widths: 30 10 60

   * - Attribute
     - Required
     - Description
   * - ``layerId``
     - Yes
     - The QGIS layer ID.
   * - ``uniqueField``
     - Yes
     - The field containing a unique value for each feature, usually the primary key.
   * - ``layerTitle``
     - No
     - The title displayed above the table.
   * - ``expressionFilter``
     - No
     - A QGIS expression to filter the features, for example ``"district_code" = 'HO'``.
       Only simple expressions are accepted: field names, values, operators and some common functions.
       For a more complex filter, create a virtual field in the layer and use it in the filter.
   * - ``sortingField``
     - No
     - The field used to sort the features. It must be a field of the layer.
   * - ``sortingOrder``
     - No
     - ``asc`` (default) or ``desc``.
   * - ``withGeometry``
     - No
     - Get the features geometries, needed to highlight them or to center the map on them.
       The geometries are fetched as soon as the attribute is present, whatever its value.
   * - ``draggable``
     - No
     - ``yes`` to let the user reorder the lines with drag and drop, ``no`` by default.
       The new order is only displayed, it is not saved: you can use the ``features.table.item.dragged``
       :ref:`event <web-component-features-table-js>` in your own JavaScript.
   * - ``data-show-highlighted-feature-geometry``
     - No
     - ``true`` to highlight on the map the geometry of the feature whose popup is displayed.
       Needs ``withGeometry``.
   * - ``data-center-to-highlighted-feature-geometry``
     - No
     - ``true`` to center the map on the feature whose popup is displayed. Needs ``withGeometry``.
   * - ``data-max-features``
     - No
     - The maximum number of features to display, ``1000`` by default.
   * - ``data-empty-message``
     - No
     - The message displayed when there is no feature to display.
   * - ``data-active-item-feature-id``
     - No
     - The ID of the feature whose popup is displayed. Set it to display the popup of a feature,
       set it to an empty value to go back to the list.

Additional fields
_________________

Each ``<lizmap-field>`` element adds a column to the table. Its content is a **QGIS expression** evaluated for each
feature: a field name between double quotes, or a simple expression.

* ``data-alias``: the column header. The expression is used if it is not set.
* ``data-description``: the tooltip of the column header.

For security reasons, the functions which can be used in these expressions are limited to:
``area``, ``$area``, ``display_expression``, ``format_date``, ``now``, ``represent_value`` and ``round``.
If another function is used, the column displays ``not allowed``.
For other needs, create a virtual field in the layer and use it in the ``<lizmap-field>`` element.

Example in a popup
__________________

In the :ref:`QGIS HTML Maptip <qgis-popup>` of a ``districts`` layer, display the sub-districts of the clicked
district, sorted by name, with two additional columns:

.. code-block:: html

    <lizmap-features-table
      layerId="sub_districts_24ceec66_e7fe_46a2_b57a_af5c50389649"
      layerTitle="Sub-districts"
      uniqueField="id"
      expressionFilter="district_code = '[% code %]'"
      sortingField="name"
      sortingOrder="asc"
      withGeometry="1"
      data-show-highlighted-feature-geometry="true"
      data-center-to-highlighted-feature-geometry="true"
    >
      <lizmap-field data-alias="Code" data-description="Sub-district code">"sub_code"</lizmap-field>
      <lizmap-field data-alias="Area (m²)">round($area, 2)</lizmap-field>
    </lizmap-features-table>

The QGIS expression ``[% code %]`` is replaced by QGIS Server with the value of the field ``code`` of the clicked
district, before the popup is sent to the browser.

.. _web-component-features-table-js:

Usage with JavaScript
_____________________

The table is reloaded when:

* its ``expressionFilter`` attribute is changed,
* its ``updated`` attribute is changed, for example with the current time, to refresh the content.

.. code-block:: javascript

    const table = document.querySelector('lizmap-features-table');
    // Display other features
    table.setAttribute('expressionFilter', `"district_code" = 'MC'`);
    // Refresh the content, for example after an edition
    table.setAttribute('updated', Date.now());
    // Display the popup of the feature 17
    table.setAttribute('data-active-item-feature-id', '17');

The component sends some events with the Lizmap events dispatcher:

.. list-table::
   :header-rows: 1
   :widths: 35 65

   * - Event
     - Properties
   * - ``features.table.rendered``
     - ``elementId`` (HTML element ID), ``itemLayerId``
   * - ``features.table.item.highlighted``
     - ``elementId``, ``itemFeatureId``, ``itemLayerId``
   * - ``features.table.item.dragged``
     - ``itemFeatureId``, ``itemOldLineId``, ``itemNewLineId``

.. code-block:: javascript

    lizMap.mainEventDispatcher.addListener(
        (lizmapEvent) => {
            console.log(`Feature ${lizmapEvent.itemFeatureId} of layer ${lizmapEvent.itemLayerId} displayed`);
        },
        ['features.table.item.highlighted']
    );

.. _web-component-feature-button:

lizmap-feature-button
---------------------

*Since Lizmap Web Client 3.10*

Description
___________

This component displays a button acting on a feature of a layer. Depending on its mode, it:

* ``popup``: opens the popup of the feature. The popup must be activated for the layer in the Lizmap plugin.
* ``edit``: launches the edition of the feature. The layer must be editable by the current user,
  with the modification of attributes or geometry allowed.
* ``create``: launches the creation of a new feature in the layer. The layer must be editable by the current user,
  with the creation allowed.

In ``popup`` and ``edit`` modes, the map can also zoom to the feature before.

If the attributes are not valid, or if the current user cannot perform the action, the button is **disabled**.
The reason is written in the web browser console.

Attributes
__________

.. list-table::
   :header-rows: 1
   :widths: 30 20 50

   * - Attribute
     - Required
     - Description
   * - ``data-target-layer-id``
     - Yes
     - The QGIS layer ID.
   * - ``data-mode``
     - No
     - ``popup`` (default), ``edit`` or ``create``.
   * - ``data-target-feature-id``
     - In ``popup`` and ``edit`` modes
     - The value of the primary key of the feature.
   * - ``data-target-layer-pk-field``
     - In ``popup`` mode
     - The primary key field of the layer, as defined in QGIS. It must be a single field:
       layers without primary key, or with a primary key made of several fields, are not supported.
   * - ``data-target-zoom-to-feature``
     - No
     - ``true`` to zoom to the feature. ``false`` by default, ignored in ``create`` mode.
   * - ``data-label``
     - No
     - The text of the button. By default, a translated text depending on the mode: *Details*, *Edit* or *Create*.
   * - ``data-description``
     - No
     - The tooltip of the button.

Examples in a popup
___________________

In the :ref:`QGIS HTML Maptip <qgis-popup>` of a ``trees`` layer, whose primary key is ``id``, add a button to edit
the clicked tree:

.. code-block:: html

    <lizmap-feature-button
      data-target-layer-id="trees_8bb24e8c_1c4b_4a23_9ad2_3fd0e3c0ab4e"
      data-target-feature-id="[% id %]"
      data-mode="edit"
      data-label="Edit this tree">
    </lizmap-feature-button>

In the same popup, add a button to display the popup of the related street and zoom to it:

.. code-block:: html

    <lizmap-feature-button
      data-target-layer-id="streets_0b5a0e47_7f3a_4bb4_9d55_6c5c3a6f2f8e"
      data-target-feature-id="[% street_id %]"
      data-target-layer-pk-field="id"
      data-target-zoom-to-feature="true"
      data-label="Street"
      data-description="Display the street of this tree">
    </lizmap-feature-button>

And a button to create a new observation:

.. code-block:: html

    <lizmap-feature-button
      data-target-layer-id="observations_3e5c6a1d_2b6f_4e0a_8c1e_7d9b4f2a6c3b"
      data-mode="create"
      data-label="New observation">
    </lizmap-feature-button>

Usage with JavaScript
_____________________

The button can also be added to the page with JavaScript:

.. code-block:: javascript

    const button = document.createElement('lizmap-feature-button');
    button.dataset.targetLayerId = 'trees_8bb24e8c_1c4b_4a23_9ad2_3fd0e3c0ab4e';
    button.dataset.targetFeatureId = '42';
    button.dataset.targetLayerPkField = 'id';
    button.dataset.targetZoomToFeature = 'true';
    document.getElementById('my-container').append(button);

The attributes are read when the element is added to the page: set them before adding it.

The component sends an event with the Lizmap events dispatcher when the action has been performed:

.. list-table::
   :header-rows: 1
   :widths: 35 65

   * - Event
     - Properties
   * - ``featurebutton.popup.displayed``
     - ``layerId``, ``featureId``
   * - ``featurebutton.edition.launched``
     - ``layerId``, ``featureId``
   * - ``featurebutton.creation.launched``
     - ``layerId``

.. code-block:: javascript

    lizMap.mainEventDispatcher.addListener(
        (lizmapEvent) => {
            console.log(`Edition launched for ${lizmapEvent.layerId} / ${lizmapEvent.featureId}`);
        },
        ['featurebutton.edition.launched']
    );
