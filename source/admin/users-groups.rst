============================================
Manage groups and users in Lizmap Web Client
============================================

.. contents::
   :depth: 3

Principles
==========

As an administrator, you can:

* **create**, **rename** or **delete** user groups
* **create**, **update** or **delete** users
* **link** a user to one or more groups

.. note::
    We highly recommend managing rights at the **group level**, not at the **user level**.

You may need to create groups to allow specific Lizmap rights :

* access to some Lizmap repositories, projects or even layers
* using editing tools, see :ref:`editing`
* access to OGC Web Services URL

.. note::
    More info about repositories rights : see :ref:`define-group-rights`

Groups created by default
=========================

Existing groups are visible on :menuselection:`Lizmap --> Administration --> Rights`.

* :guilabel:`admins` : to manage **all** settings on the Lizmap instance
* :guilabel:`publishers` : designed for GIS technicians, to allow accessing server information needed from the QGIS plugin.
  The right ``lizmap.admin.server.information.view`` must be enabled.
* :guilabel:`users` : to recognise a connected user, to allow some basic rights like changing his own password
* :guilabel:`__anonymous` : a "special" group for a non connected user, which allows to set rights for non connected users

:guilabel:`Default group` are the groups in which any new user is automatically added.

Manage users
============

On :menuselection:`Lizmap --> Administration --> Users`, you can:

* *create* a new user
* *edit* a user
* *add* a user to an existing group
* *remove* a user from a group
* *remove* a user from the instance

.. tip::
    Once users have been created, you must add them into groups to grant associated rights.

.. warning::
    According to the server configuration, the user receives a link to set his own password.
    If you want to change this behavior, read :ref:`set-password`, if you are the system administrator.

Rights
======

Groups
^^^^^^

On :menuselection:`Lizmap --> Administration --> Rights`, you land by default on :guilabel:`User groups`.

You can:

* *create* a new group
* *edit* the group name
* *set* the rights for a group
* *remove* a group

Users
^^^^^^

On :menuselection:`Lizmap --> Administration --> Rights`, you have a another tab called :guilabel:`Users`.

You can:

* *see* the list of users and its groups
* for a given *user*:

    * *see* the list of groups
    * *see* the **resulting rights**

Assigning groups automatically for each new user created
--------------------------------------------------------

On :menuselection:`Lizmap --> Administration --> Rights`, in the :guilabel:`Default group` column, click the pencil ✏️
button to allow or deny the group as default.

The default is set to the :guilabel:`users` group.

Lizmap plugin
=============

The list of settings in the plugin where a list of users or groups can be set:

* :menuselection:`Map options --> Generic options`, to make the project visible only to subset of groups
* :menuselection:`Layers --> Group visibility`, to make the layer visible only to subset of groups
* :menuselection:`Layer editing --> Layer`, to allow editing capabilities on a layer, see :ref:`editing`
* :menuselection:`Filter by user`, both :guilabel:`Attribute filtering` or :guilabel:`Spatial filtering`,
  see :ref:`filtered-layer-by-user`
