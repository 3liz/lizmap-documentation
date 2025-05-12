
Information — Get some news about the project and your server
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
    3. Write the login and password of an **administrator** or a **publisher** used in the web interface to access the administration panel.
       QGIS might ask you to setup the **master password**. It's a password to protect the QGIS internal password manager. This password
       is used only on **your** computer. The Lizmap plugin is storing the login and password in the
       `QGIS password manager <https://docs.qgis.org/latest/en/docs/user_manual/auth_system/auth_overview.html#master-password>`_.

.. warning::
    Do not use the any URL redirection. For instance, https://demo.lizmap.com/ is a redirection to
    https://demo.lizmap.com/lizmap/. Only the second one will work.

Request for support
-------------------

When requesting support on a website, it might be required or highly recommended to copy/paste versions used on your server.
This helps a lot to know your environment and to know if the bug is a new one or already fixed. So you should have your
server available in the table mentioned above, **with** an administrator login.

Then, right-click on your server, then :menuselection:`Copy all versions in your clipboard for a support request…`. You can
go back on your support request and do a right click and paste.

.. warning::
    When clicking in the QGIS plugin, you might have some actions displayed **in a popup**. You **should** check these
    actions, like to be sure to provide an administrator login, have QGIS server installed correctly, running a
    maintained version of Lizmap Web Client etc. Check your version on the
    `release page <https://github.com/3liz/lizmap-web-client/releases>`_.

..  image:: /images/information_tab_clipboard.jpg
   :align: center
