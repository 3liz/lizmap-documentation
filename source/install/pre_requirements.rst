================================================
Requirements before installing Lizmap Web Client
================================================

.. note:: If you want to quickly install and test Lizmap Web Client in a few steps, you can follow those `instructions <https://github.com/3liz/lizmap-docker-compose#run-lizmap-stack-with-docker-compose>`_.

QGIS Server
===========

Follow the QGIS Documentation how to install QGIS Server : https://docs.qgis.org/3.16/en/docs/server_manual/

Using a webserver (Apache or Nginx), you must install QGIS Server. With Nginx, the preferred way is to use
``spawn-fcgi``.

.. warning::
    Nginx with ``fcgiwrap`` is not efficient, but it's mentioned in the QGIS Server documentation. Better to
    use ``spawn-fcgi``.

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

QGIS Server plugins
-------------------

Some plugins can be added to QGIS Server. This will enable some features in Lizmap. It's not compulsory but
in some situations, it's better.

Either you should setup the ``QGIS_PLUGIN_PATH`` environment variable during the installation of QGIS Server
or use the default one provided by QGIS.
https://docs.qgis.org/3.16/en/docs/server_manual/config.html#environment-variables

* AtlasPrint : To enable the PDF based on a QGIS Layout Atlas https://github.com/3liz/qgis-atlasprint
* Lizmap : Lizmap **is not only** a PHP application, there is also Python plugin for **QGIS Server** to evaluate
  QGIS Expressions in forms https://github.com/3liz/lizmap-plugin/
* WfsOutputExtension : To add new format when exporting vector data https://github.com/3liz/qgis-wfsOutputExtension
* Logging : To log QGIS Servers log and to flush the cache on QGIS Server https://github.com/3liz/qgis-logging-plugin
