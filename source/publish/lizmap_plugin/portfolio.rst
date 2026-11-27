.. include:: ../../substitutions.rst

.. _portfolio:

Portfolios — Print several layouts at once
==========================================

.. contents::
   :depth: 3

Principle
---------

A **portfolio** is a set of **folios**. Each folio is a QGIS print layout combined with a QGIS map theme.

In Lizmap Web Client, the user chooses a portfolio and draws a point, a line or a polygon on the map. Lizmap then
generates one PDF for each folio of the portfolio, centered on the drawn geometry, using the layers and styles of
the map theme of the folio.

For instance, with a single click on a parcel, a user can get a location map, a cadastral map and an aerial view
of this parcel, each one with its own layout and its own layers.

Prerequisites
-------------

* At least one print layout in the QGIS project, read :ref:`printing`.
* At least one map theme in the QGIS project. To create your themes, follow the
  `QGIS documentation about map themes <https://docs.qgis.org/latest/en/docs/user_manual/introduction/general_tools.html#configuring-map-themes>`_.

Configuring the tool
--------------------

In the Lizmap plugin, open the :guilabel:`Portfolios` panel.

- To add a portfolio:

    1. .. include:: ../../shared/add_layer.rst
    2. Set the :guilabel:`Title` displayed in Lizmap Web Client.
    3. Optionally, set a :guilabel:`Description`, HTML is supported.
    4. Choose the :guilabel:`Geometry` the user will draw on the map: ``Point``, ``Line`` or ``Polygon``.
    5. Add one or more folios. For each folio, choose:

        + the :guilabel:`Layout`, the QGIS print layout to use,
        + the :guilabel:`Theme`, the QGIS map theme to apply,
        + the :guilabel:`Zoom method`:

          * ``Fixed scale``, the map is centered on the geometry at the given scale. This is the only method
            available for a ``Point`` geometry.
          * ``Best scale``, the map is zoomed on the extent of the geometry. Only for ``Line`` and ``Polygon``.
          * ``Margin (%)``, the map is zoomed on the extent of the geometry with a margin, as a percentage.
            Only for ``Line`` and ``Polygon``.

- .. include:: ../../shared/edit_layer.rst
- .. include:: ../../shared/remove_layer.rst
- .. include:: ../../shared/move_up_down_layer.rst

Usage in Lizmap Web Client
--------------------------

When at least one portfolio is configured, a :guilabel:`Portfolios` panel is available in the menu.

#. Choose a portfolio in the list, its description is displayed.
#. Draw the geometry on the map.
#. Click on :guilabel:`Run` to generate the PDF files, one file per folio. The name of each file contains the theme
   and the scale used.
#. Click on :guilabel:`Deactivate` to stop drawing.
