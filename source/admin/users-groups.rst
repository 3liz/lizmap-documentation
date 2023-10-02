============================================
Manage groups and users in Lizmap Web Client
============================================

.. contents::
   :depth: 3

The groups and users: principles
================================

As an administrator, you can:

* create, rename, delete user groups
* create, modify, delete users
* linking a user to one or more groups

.. note:: Rights on Lizmap Web Client repositories are managed at group level, not at the user level.

You may need to create group to allow specific lizmap rights :

* access to some repositories, projects or even layers
* using edition tools
* access to OGC Web Services URL

.. note:: more info about repositories rights : see :ref:`define-group-rights`


Manage Groups: create, rename, delete
=====================================

* *Create a group*: In the left menu click on *rights* and use the button *Create a group*.
* Define the *Group name*: it is possible to use spaces and accents
* Define the *Group id*: one word without special characters, usually will be generated from group name, but can be modified

In this page, it is also possible to *Change the name* and *Delete a group*.


.. note::
    The **users** group is a group system to give the rights to authenticated users to edit their own user information
    including passwords. We excluded this group of Lizmap Web Client configuration because all identified users must be
    part of this group.

Manage Users
============

* *Create a user* : In the left menu click on *Users* and click on the button *Create a new user*:

  - give a *Nickname* which will be used for the login
  - give an email
  - set name and firstname

* The user will have an email for setting up his password. If you want to set the password yourself, read the section below.
* It is also possible to *view* and *edit* informations about users.

.. warning:: Once users created, you must put them into groups to assign the associated rights.


Putting users in groups
=======================

* In the left menu click on *Users*
* it is possible to search for users using the input field
* to put a user in groups, click on the its button *view*

  - The page displays details of the user
  - The footer shows *Groups the user belongs to*
  - You can add user to existing group using the listbox and the *add button*


Assigning groups for each user created
--------------------------------------

* In the left menu click on *Rights*
* The page display all the existing groups, with a column *Default group*
* Use the pencil ✏️ button to allow or deny the group as default for new users

Example
=======

As an example, you have two projects (X, Y), that need to be viewable by logged users and you want to allow some users to edit only X, others to edit only Y.
The view and edition rights are managed in the repository level, thus  :

* You need to create 3 groups :

  - users_that_can_see_repos
  - users_that_can_edit_repo_x
  - users_that_can_edit_repo_y

* You need to create a repository for each project (repo_x, repo_y)
* For repo_x, you allow *Use the Edition tool* for group 'users_that_can_edit_repo_x', and allow *View Repositories* for 'users_that_can_see_all_repos'.
* For repo_y, you allow *Use the Edition tool* for group 'users_that_can_edit_repo_y', and allow *View Repositories* for 'users_that_can_see_all_repos'.

When you create a new user, add it to group 'users_that_can_see_all_repos', it will be able to see both projets, and add to group 'users_that_can_edit_repo_x' if you want to allow the user to edit data.

