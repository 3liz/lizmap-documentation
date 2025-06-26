==============
Py-QGIS-Server
==============

`Py-QGIS-Server <https://docs.3liz.org/py-qgis-server/>`_ has been designed to manage QGIS Server map processes.

Pre-requirements
================

We suppose that you already have installed QGIS Server packages, as explained in the
`QGIS Server documentation <https://docs.qgis.org/latest/en/docs/server_manual/>`_.

.. note::
    You do not need to read the web server configuration about Nginx/Apache in the documentation from QGIS.
    Because Py-QGIS-Server has its **own** web server.

Install in a Python venv
========================

We add needed packages not provided with QGIS Server :

.. code-block:: bash

    apt install python3-venv python3-psutil

Then, we create the Py-QGIS-Server virtual environment and install ``py-qgis-server`` with pip :

.. code-block:: bash

    set -e
    python3 -m venv /opt/local/py-qgis-server --system-site-packages
    /opt/local/py-qgis-server/bin/pip install -U pip setuptools wheel pysocks typing py-qgis-server

Py-QGIS-Server is installed.

Configuration and associated files
===================================

Folders used below
------------------

.. code-block:: bash

    mkdir -p /srv/qgis/plugins /srv/qgis/config /srv/data /var/log/qgis /var/lib/py-qgis-server

The file to watch for restarting workers
----------------------------------------

We create an empty file that will be watched by Py-QGIS-Server to check when to restart QGIS Server map workers.

.. code-block:: bash

    touch /var/lib/py-qgis-server/py-qgis-restartmon
    chmod 664 /var/lib/py-qgis-server/py-qgis-restartmon


The bash file to restart workers
--------------------------------

We create the executable file :file:`/usr/bin/qgis-reload` to restart QGIS Server map workers. It will contain:

.. code-block:: bash

    #!/bin/bash

    touch /var/lib/py-qgis-server/py-qgis-restartmon


Then we change its mod :

.. code-block:: bash

    chmod 750 /usr/bin/qgis-reload

The configuration file
----------------------

We create the Py-QGIS-Server configuration file :file:`/srv/qgis/server.conf`. It will contain:

.. code-block:: bash

    #
    # Py-QGIS-Server configuration
    # https://docs.3liz.org/py-qgis-server/
    #
    
    [server]
    port = 7200
    interfaces = 127.0.0.1
    workers = 4
    pluginpath = /srv/qgis/plugins
    timeout = 200
    restartmon = /var/lib/py-qgis-server/py-qgis-restartmon
    
    [logging]
    level = info
    
    [projects.cache]
    strict_check = false
    rootdir = /srv/data
    size = 50
    advanced_report = no

    [monitor:amqp]
    routing_key =
    default_routing_key=
    host =
    
    [api.endpoints]
    lizmap_api=/lizmap
    
    [api.enabled]
    lizmap_api=yes

In this example:

* QGIS Server will be available at ``http://127.0.0.1:7200/ows/``
* the plugins are installed in :file:`/srv/qgis/plugins` (``pluginpath``). See :ref:`qgis-server-plugins`.
* the file to watch for restarting workers is :file:`/var/lib/py-qgis-server/py-qgis-restartmon` (``restartmon``).
* the directory containing the projects to be published :file:`/srv/data` (``rootdir``). The projects must be in sub-folders.
* Lizmap QGIS Server API is enabled

Manage it with systemd
----------------------

First of all, we create an environment file :file:`/srv/qgis/config/qgis-service.env` with

.. code-block:: bash

    LC_ALL=en_US.UTF-8
    LANG=en_US.UTF-8
    DISPLAY=:99
    QGIS_OPTIONS_PATH=/srv/qgis/
    QGIS_AUTH_DB_DIR_PATH=/srv/qgis/
    GDAL_CACHEMAX=2048
    QGIS_SERVER_CACHE_SIZE=2048
    QGIS_SERVER_LIZMAP_REVEAL_SETTINGS=TRUE
    QGIS_SERVER_FORCE_READONLY_LAYERS=TRUE
    QGIS_SERVER_TRUST_LAYER_METADATA=TRUE
    QGIS_SERVER_APPLICATION_NAME=qgis-server

In this file, we defined:

* The language
* The Xvfb display port, needed to print PDF
* The QGIS options and ``authDB`` path (needed for HTTPS, when used in remote layers such as OSM tiles)
* Lizmap environment variable to reveal settings
* Other QGIS Server variables, from the `documentation <https://docs.3liz.org/py-qgis-server/configuration.html#common-configuration-options>`_.

Then we can create the QGIS `service systemd file <https://wiki.debian.org/systemd/Services>`_ :file:`/etc/systemd/system/qgis.service` with

.. code-block:: bash

    [Unit]
    Description=QGIS server
    After=network.target
    
    [Service]
    Type=simple
    
    ExecStart=/opt/local/py-qgis-server/bin/qgisserver -c /srv/qgis/server.conf
    
    # FIXME it is recommended to have a script *synchronous*, which is not the case here
    ExecReload=/usr/bin/qgis-reload

    KillMode=control-group
    KillSignal=SIGTERM
    TimeoutStopSec=10
    
    Restart=always
    
    StandardOutput=append:/var/log/qgis/qgis-server.log
    StandardError=inherit
    SyslogIdentifier=qgis
    
    EnvironmentFile=/srv/qgis/config/qgis-service.env
    User=root
    
    LimitNOFILE=4096
    
    [Install]
    WantedBy=multi-user.target

Finally, we enable the QGIS Server service to start at system launch and we also start the service right now :

.. code-block:: bash

    systemctl enable qgis
    service qgis start

Debug and check
---------------

.. tip::

    1. We can check that QGIS Server with Py-QGIS-Server is working with :
    ``curl http://127.0.0.1:7200/ows/``

    2. After the installation of **Lizmap Server** QGIS plugin, we can check with :
    ``curl http://127.0.0.1:7200/lizmap/server.json | jq '.'``
    Read :ref:`qgis-server-plugins` with the use of QGIS-Plugin-Manager.

Adapt the Lizmap Web Client configuration
-----------------------------------------

Either by editing manually the file :file:`lizmap/var/config/lizmapConfig.ini.php` or by changing in Lizmap Web Client GUI :

.. code-block:: bash

    [services]
    ;URL to QGIS Server for OGC web services
    wmsServerURL="http://127.0.0.1:7200/ows/"
    ;URL to the API exposed by the Lizmap plugin for QGIS Server
    lizmapPluginAPIURL="http://127.0.0.1:7200/lizmap/"

    ; path to find repositories
    rootRepositories="/srv/data"

Your :guilabel:`Server information` panel must show you the QGIS Server version and installed plugins.

.. note::
    If you want to know more about Py-QGIS-Server, read its dedicated
    `Py-QGIS-Server documentation <https://docs.3liz.org/py-qgis-server/>`_, like preloaded projects, API management, etc.
