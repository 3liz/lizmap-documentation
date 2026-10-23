========================================
Overview of the administration interface
========================================

.. contents::
   :depth: 3

Change password
===============

Once connected, it is possible to change the password:

* Click on your login at the top right menu and then *Your account*
* Click on the button *Change your password*
* Type the new password, confirme it and save

.. warning::
    It is imperative to change your password. Use a complex password that mixes numbers, letters and punctuation.


Reminder on Lizmap Web Client repositories
==========================================

Lizmap Web Client can use QGIS maps stored in different folders on the server.

* A *Lizmap Web CLient repository* is a folder on the server that stores one or more QGIS projects and their related data.
* Repositories can be used to *group related projects by theme*.
* Repositories can be used to *manage the access rights on maps*.

.. _admin-permalinks:

Permalinks
==========

When the :ref:`short permalink <short-permalink>` is enabled in a project, the parameters of each permalink are stored
on the server. The :guilabel:`Permalinks` page of the administration interface shows the number of stored permalinks
and allows to:

* see the list of permalinks, with their repository, project, creation date and last usage date,
* delete the permalinks which have not been used for a given number of days,
* delete all the permalinks.

.. warning::
    A deleted permalink cannot be opened anymore.

This page is available to the users having the right :guilabel:`Manage server side permalinks`, given to the
administrators by default.
