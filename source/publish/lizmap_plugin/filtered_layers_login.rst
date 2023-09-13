.. include:: ../../substitutions.rst
.. _filtered-layer-by-user:

Filtered layer by user — Set some features visible/editable or not for some users
==================================================================================

.. contents::
   :depth: 3

Principle
---------

The filtering feature presented allows you to filter the data displayed on the map based on the logged in user.
It is possible to filter only vector layers because Lizmap uses a column in the attribute table.

Filtering currently uses the ID of the user group connected. It's active for all requests to QGIS server,
and thus concerns:

* the vector layers images displayed on the map
* the popups. See :ref:`popup`
* the *Locate by layer* feature lists. See :ref:`locate-by-layer`
* drop-down lists of *Editing forms* from *Value relation*. See :ref:`editing`
* the attribute table display etc

There are two kinds of filtering :

* based on attributes
* based on spatial relationship

Filtering by spatial relationship
---------------------------------

Principle
^^^^^^^^^

In this panel, we can:

* configure a polygon layer to use for spatial filtering
* configure layers which must be filtered by the filtering layer

..  image:: /images/filter-polygon.gif
   :align: center

Prerequisites
^^^^^^^^^^^^^

The Lizmap plugin in QGIS Server **must** be installed with at least **Lizmap QGIS plugin 3.6**.
Otherwise, the filter won't work and all data will be visible.
See :ref:`lizmap-server-plugin`.

Configuring the tool
^^^^^^^^^^^^^^^^^^^^

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

Filtering by attribute
----------------------

Example
^^^^^^^

A video tutorial is available at: https://vimeo.com/83966790

Configuring the tool
^^^^^^^^^^^^^^^^^^^^

To use data filtering tool in Lizmap Web Client, you must:

* have **access to the administration interface** of Lizmap Web Client

Here are the detailed steps to configure this feature:

.. warning::
    In Lizmap Web Client administration, in the repository properties, be sure that ``anonymous`` and other relevant groups are not checked
    for :guilabel:`Always see complete layers data, even if filtered by login`. See :ref:`define-group-rights`.

* Check group ID or user ID in the administration interface:

    * To know group ID, you must go to the administration interface :menuselection:`SYSTEM --> Groups of users for rights`: ID appears in parentheses after the name of each group (under the title :guilabel:`Groups of new users`)
    * Or to know the user ID, just use its login.

* For all vector layers which is desired filter data, just add a text column that will hold the ID for each line who has the right to display this feature.

    * *Fill this column* for each line of the attribute table with the ID (using the calculator, for example).
    * It is possible to set ``all`` as the value in some lines to disable the filter: All users will see the data for these lines.
    * If the value in this column for a row does not correspond to a user group, then the data will be displayed for no user.

..  image:: /images/interface-add-filter-by-login.jpg
   :align: center

- Add the layer in the table :guilabel:`Filter Data by User` panel:

    1. .. include:: ../../shared/add_layer.rst
    2. Select layer from the dropdown list
    3. Select the field with the ID
    4. Check the box if the field contains user ID, instead of group ID

- .. include:: ../../shared/edit_layer.rst
- .. include:: ../../shared/remove_layer.rst

.. warning::
    Disable the client cache and cache server for all filtered layers. Otherwise, the data displayed will not be updated between each connection or user logout!

Edition
^^^^^^^

If you have enabled the edition (see :ref:`editing`) on the filtered layer, the field containing the ID will be editable with:

* either a combobox for a non admin user with either his own login or ``all``
* or a line edit to write a value for a admin user
