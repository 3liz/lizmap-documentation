================================================
Requirements before installing Lizmap Web Client
================================================

.. note::
    If you want to quickly install and test Lizmap Web Client in a few steps, you can follow those
    `instructions <https://github.com/3liz/lizmap-docker-compose>`_ using Docker and Docker-Compose.

QGIS Server
===========

.. warning::
    Before installing the QGIS Server part, it is **very highly** recommended to use the **same** version
    between QGIS Desktop and QGIS Server.

    Even if some functions might work, there is a probability that some configuration won't work if these two
    versions are **different**.

    The reason is QGIS Server version X might not be able to a QGIS project made with a QGIS Desktop version Y.

Follow the `QGIS Server documentation on how to install QGIS Server <https://docs.qgis.org/latest/en/docs/server_manual/>`_.

Using a webserver (Apache or Nginx), you must install QGIS Server. With Nginx, the preferred way is to use
``spawn-fcgi``. Do **not** use the ``fcgiwrap``, this solution is not efficient.

In the Nginx configuration, it's good to use the ``QGIS_OPTIONS_PATH`` variable for a folder with write
permissions for ``www-data``. These is explained in the QGIS Server documentation.

You should also install and configure ``XVFB`` mentioned in the QGIS Documentation.
This is useful for printing PDF. You can only skip this section if you don't plan to print PDF on the server
side.

After you have setup your web server with QGIS-Server, check that the URL of QGIS Server is working. You
probably get a XML like:

.. code-block:: xml

    <ServerException>Project file error</ServerException>

Keep this URL, we will use it later in the Lizmap admin panel.

.. warning::
    We **strongly** encourage you to set up QGIS Server on a different virtual host than Lizmap Web Client.
    QGIS Server URL should stay private, accessible by the Lizmap PHP application **only**.

    Otherwise, especially after the **Lizmap** plugin on QGIS Server is installed, your user might be able to
    access private data if they by-pass Lizmap, by using straight QGIS Server URL.

QGIS Server plugins
-------------------

Some plugins can be added to QGIS Server. Please check the `QGIS Server documentation <https://docs.qgis.org/latest/en/docs/server_manual/plugins.html>`_
about plugins on the server side.

.. warning::
    The **Lizmap server** plugin is required.

Plugins listed below will enable some features in Lizmap Web Client.

Either you should setup the ``QGIS_PLUGINPATH`` environment variable during the installation of QGIS Server
or use the `default one provided by QGIS <https://docs.qgis.org/latest/en/docs/server_manual/config.html#environment-variables>`_.

.. tip::
    To manage QGIS Server plugins, we encourage you to use **qgis-plugin-manager**, a CLI tool to install and
    upgrade plugins. https://pypi.org/project/qgis-plugin-manager/

* AtlasPrint

    * To enable the PDF based on a QGIS Layout Atlas
    * https://github.com/3liz/qgis-atlasprint

* Cadastre

    * French use-case only
    * Needed for the Lizmap Cadastre module
    * https://docs.3liz.org/QgisCadastrePlugin/module-lizmap/

* Lizmap server

    * Lizmap **is not only** a PHP application, there is also Python plugin for **QGIS Server** called **Lizmap server**.
    * https://github.com/3liz/qgis-lizmap-server-plugin
    * The plugin is **required**.
    * **Important**, read below for more information the Lizmap QGIS Server plugin. (:ref:`lizmap-server-plugin`)

* WfsOutputExtension

    * To add new format when exporting vector data
    * https://github.com/3liz/qgis-wfsOutputExtension

* Logging

    * To log QGIS Servers log and to flush the cache on QGIS Server
    * https://github.com/3liz/qgis-logging-plugin.
    * This plugin is deprecated.

.. _lizmap-server-plugin:

Lizmap QGIS Server plugin
_________________________

The Lizmap QGIS Server plugin **is required** and will add some features on Lizmap Web Client :

        * retrieve information from QGIS Server.

        * evaluate `QGIS Expressions <https://docs.qgis.org/testing/en/docs/user_manual/working_with_vector/expression.html>`_
          in forms about :

           * constraints
           * default value
           * group visibility
           * Read :ref:`edition-expressions`.

        * check User Access Rights (ACL) for features and layers :

           * filter by polygon
           * by attribute

        * use the **Form** popup, read :ref:`form-popup`.
        * enable ``@lizmap_user`` and ``lizmap_user_groups`` variables in QGIS projects

    * https://github.com/3liz/qgis-lizmap-server-plugin
    * The name of the plugin is ``Lizmap server``. Do not install the ``Lizmap`` plugin which is the **desktop** Python plugin.

Installation
^^^^^^^^^^^^

QGIS Server side
****************

Please check the `QGIS Server documentation <https://docs.qgis.org/latest/en/docs/server_manual/plugins.html>`_ about plugins
on the server side.

The Lizmap server plugin, called ``Lizmap server``, **is required** in the correct folder for QGIS Server.

With `QGIS-Plugin-Manager <https://pypi.org/project/qgis-plugin-manager/>`_ :

.. code-block:: bash

    # Not correct, this plugin is only for QGIS desktop
    # qgis-plugin-manager install Lizmap

    # Correct, the plugin designed for QGIS server
    qgis-plugin-manager install 'Lizmap server'

.. warning::
    You must install the ``Lizmap server`` plugin. The ``Lizmap`` plugin is designed only for QGIS desktop. Do not
    keep both on your server.

For **security** reason, to enable the API on the QGIS server side, you must enable the environment variable
    ``QGIS_SERVER_LIZMAP_REVEAL_SETTINGS`` with the value set to ``True`` on QGIS server.
    
This variable will **expose** server settings such as QGIS server version, which is used by Lizmap Web Client.

.. code-block:: ini

    # Apache FCGI example 
    FcgidInitialEnv QGIS_SERVER_LIZMAP_REVEAL_SETTINGS True
    # nginx fastcgi 
    fastcgi_param  QGIS_SERVER_LIZMAP_REVEAL_SETTINGS  True;


.. warning::

    You **must** be ensured that this API ``http://your.qgis.server.url/lizmap/server.json`` is protected on
    your webserver. The **best** is to restrict the access to QGIS server ``http://your.qgis.server.url`` on a
    virtual host, not accessible on the internet. All requests to QGIS server will be sent by Lizmap Web Client.
    QGIS server mustn't be accessible from outside. It was already **highly** recommended before to protect the QGIS Server
    from the internet. Users **must use** WFS/WMS links provided by Lizmap Web Client, so Lizmap can check user permissions.

    
Administration panel
********************

If your are using QGIS Server with **FCGI**, the Lizmap API URL **must** be empty.

Otherwise, if you are using `Py-QGIS-Server <https://docs.3liz.org/py-qgis-server/>`_, the Lizmap API URL **must** be
configured in the administration interface. In **Py-QGIS-Server**, you must explicitly publish the API as well.

Starting from Py-QGIS-Server version 1.8.4, it's possible to enable the Lizmap API endpoint with the environment variable
`QGSRV_API_ENDPOINTS_LIZMAP=yes` otherwise, add the configuration below in your configuration file :

.. code-block:: ini

    [api.endpoints]
    lizmap_api=/lizmap

    [api.enabled]
    lizmap_api=yes

Then, with Py-QGIS-Server, if your URL for OWS is `http://map:8080/ows/`, it means the URL for the Lizmap API endpoint is
`http://map:8080/lizmap/`.

.. _prerequisites-postgresql:

PostgreSQL
----------

PostgreSQL can be used for **three** different purposes in Lizmap :

* To store GIS data. **No** configuration is needed on the Lizmap Web Client server side, **only** the PostgreSQL server
  must be accessible from the Lizmap Web Client server and QGIS Server.
  It's possible to edit layers with Lizmap, but the layer **must** be stored in PostgreSQL. See :ref:`edition-prerequisites`.
* To store Lizmap Web Client users and user actions. Lizmap uses tables. This setting must be done when **installing** Lizmap.
* To use `lizmap_search`, see :ref:`postgresql-lizmap-search`. This setting on the Lizmap server can be set when you need it.
