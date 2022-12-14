.. include:: ../../substitutions.rst

Information - Get some news about the project and your server
=============================================================

.. contents::
   :depth: 3

Principle
---------

In this panel, we can :

* find some links about Lizmap social networks
* be aware of a new release regarding Lizmap Web Client. Only two branches are maintained simultaneously.
  If you branch is not listed, it's not maintained anymore, except if you are using the `master` branch.
* set the target Lizmap Web Client version. You will be aware which features are available or not on your
  server.
* check your Lizmap Web Client server's version

Configuring the tool
--------------------

..  image:: /images/information_tab.jpg
   :align: center

- For adding a new server :

    1. Click |add_layer_svg|
    2. Write the URL of the Lizmap Web Client server. The URL should be the main Lizmap landing page.
    3. If possible, use a login and password of a Lizmap Web Client administrator. It will give you more information about the server.
       This is optional.
       QGIS might ask you to setup the **master password**. It's a password to protect the QGIS internal password manager. This password
       is used only on **your** computer. The Lizmap plugin is storing the login and password in the `QGIS password manager <https://docs.qgis.org/latest/en/docs/user_manual/auth_system/auth_overview.html#master-password>`_.

.. warning::
    Do not use the any URL redirection. For instance, https://demo.lizmap.com/ is a redirection to
    https://demo.lizmap.com/lizmap/. Only the second one will work.
