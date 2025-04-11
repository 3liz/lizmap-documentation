=======================
Install Py-QGIS-Server
=======================

Py-QGIS-Server has been build to manager QGIS Server map processes.

Install in a venv
==================

We supposed, you already installed QGIS Server packages has explain in the QGIS Servr documentation.

We firstly add needed pacakges not provided with QGIS Server.

.. code-block:: bash

    apt install python3-venv python3-psutil

Then, we create the py-qgis-server virtual environment and install py-qgis-server

.. code-block:: bash

    set -e
    python3 -m venv /opt/local/py-qgis-server --system-site-packages
    /opt/local/py-qgis-server/bin/pip install -U pip setuptools wheel pysocks typing py-qgis-server

Py-QGIS-Server is installed.

Configuration and associated files
===================================

The file to watch for restarting workers (restartmon)
-----------------------------------------------------

We create an empty file that will be watch by py-qgis-server to check when restarting QGIS Server map workers.

.. code-block:: bash

    mkdir /var/lib/py-qgis-server
    nano /var/lib/py-qgis-server/py-qgis-restartmon
    chmod 664 /var/lib/py-qgis-server/py-qgis-restartmon


The bash file to restarting workers (qgis-reload)
--------------------------------------------------

We create the file ``/usr/bin/qgis-reload`` to launch restarting QGIS Server map workers. It will contain:

.. code-block:: bash

    #!/bin/bash

    touch /var/lib/py-qgis-server/py-qgis-restartmon


Then when change its mod :

.. code-block:: bash

    chmod 750 /usr/bin/qgis-reload

The configuration file
-----------------------

We create the Py-QGIS-Server configuration file ``/srv/qgis/server.conf``. It will contain:

.. code-block:: bash

    #
    # py-qgis-server configuration
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

In this exemple:

* QGIS Server will be available at ``http://127.0.0.1:7200/ows/``
* the plugins are installed in ``/srv/qgis/plugins`` (pluginpath).
* the file to watch for restarting workers is ``/var/lib/py-qgis-server/py-qgis-restartmon`` (restartmon).
* the directory containing the projects to be published ``/srv/data`` (rootdir). The projects can be in sub-folders, like root repositores in Lizmap Web Client.
* Lizmap QGIS Server API is enabled

Manage it with systemd
-----------------------

Fisrt of all, we create an environment file ``/srv/qgis/config/qgis-service.env`` with 

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

In this file we defined:

* The lang 
* The Xvfb display port 
* The QGIS options and authDB path (needed for https sources)
* Lizmap environment varaible to reveal settings 
* Other QGIS Server variables

Then we can create the QGIS service file ``/etc/systemd/system/qgis.service`` with 

.. code-block:: bash

    [Unit]
    Description=Qgis server
    After=network.target
    
    [Service]
    Type=simple
    
    ExecStart=/opt/local/py-qgis-server/bin/qgisserver -c /srv/qgis/server.conf
    
    #FIXME il est recommandé d'avoir un script *synchrone*, ce qui n'est pas le cas ici
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

Finally, we enable the QGIS Server service to start it and to be sure it is started at system launch.

Adapt the Lizmap Web Client config
-----------------------------------

If you use Py-QGIS-Server, you have to adapt the Lizmap Web CLient config. You have to update the ``lizmap/var/config/lizmapConfig.ini.php` and change these options:

.. code-block:: bash

    [services]
    ;Wms map server
    wmsServerURL="http://127.0.0.1:7200/ows/"
    ;URL to the API exposed by the Lizmap plugin for QGIS Server
    lizmapPluginAPIURL="http://127.0.0.1:7200/lizmap/"

    ; path to find repositories
    rootRepositories="/var/data"