===============================================================
Configurating the map server for Lizmap Web Client
===============================================================

This documentation provides an example for configuring a server with the Ubuntu Server 12.04 LTS distribution.

Generic Server Configuration
===============================================================

Configure Locales
--------------------------------------------------------------

For simplicity, it is interesting to configure the server with UTF-8 default encoding.

.. code-block:: bash

   # locales
   locale-gen fr_FR.UTF-8
   dpkg-reconfigure locales
   dpkg-reconfigure tzdata

.. note:: It is also necessary configure the other softwares so that they are using this default encoding if this is not the case.

Installing some useful libraries
-------------------------------------------

* Updating packages

.. code-block:: bash

   # Updating packages
   apt-get update
   apt-get upgrade

* Installing all the packages that will be used for map server

.. code-block:: bash

   apt-get install python-simplejson xauth htop nano curl ntp ntpdate python-software-properties git


Create directories for data
-------------------------------------------

.. code-block:: bash

   mkdir /home/data
   mkdir /home/data/cache/
   mkdir /home/data/ftp
   mkdir /home/data/ftp/template/
   mkdir /home/data/ftp/template/qgis
   mkdir /home/data/postgresql
   

Web Server : Apache
======================================

Installing necessary packages
-------------------------------------

.. code-block:: bash

   apt-get install apache2 apache2-mpm-worker libapache2-mod-fcgid php5-cgi php5-curl php5-cli php5-sqlite php5-gd
   a2dismod php5
   a2enmod actions
   a2enmod fcgid
   a2enmod ssl
   a2enmod rewrite
   a2enmod headers
   a2enmod deflate

Setting the compression
-------------------------------
.. code-block:: bash

   nano /etc/apache2/conf.d/mod_deflate.conf # y ajouter
   <Location />
           # Insert filter
           SetOutputFilter DEFLATE
           # Netscape 4.x encounters some problems ...
           BrowserMatch ^Mozilla/4 gzip-only-text/html
           # Netscape 4.06-4.08 encounter even more problems
           BrowserMatch ^Mozilla/4\.0[678] no-gzip
           # MSIE pretends it is Netscape, but all is well
           BrowserMatch \bMSIE !no-gzip !gzip-only-text/html
           # Do not compress images
           SetEnvIfNoCase Request_URI \.(?:gif|jpe?g|png)$ no-gzip dont-vary
           # Ensure that proxy servers deliver the right content
           Header append Vary User-Agent env=!dont-vary
   </Location>


php5 configuration
-----------------------

In this example, we use Apache mpm-worker. So we must manually configure the activation of php5.

.. code-block:: bash

   cat > /etc/apache2/conf.d/php.conf << EOF
   <Directory /usr/share>
     AddHandler fcgid-script .php
     FCGIWrapper /usr/lib/cgi-bin/php5 .php
     Options ExecCGI FollowSymlinks Indexes
   </Directory>

   <Files ~ (\.php)>
     AddHandler fcgid-script .php
     FCGIWrapper /usr/lib/cgi-bin/php5 .php
     Options +ExecCGI
     allow from all
   </Files>
   EOF

   note:: In later versions of apache, the config for ``php-cgi`` is in ``/etc/apache2/conf-available/php.conf``. Copy the text above, then::

  a2enconf php

mpm-worker configuration
-----------------------------

We modify the Apache configuration file to adapt the options to mpm_worker server configuration.

.. code-block:: bash

   # configuring worker
   nano /etc/apache2/apache2.conf # aller au worker et mettre par exemple
   <IfModule mpm_worker_module>
     StartServers       4
     MinSpareThreads    25
     MaxSpareThreads    100
     ThreadLimit          64
     ThreadsPerChild      25
     MaxClients        150
     MaxRequestsPerChild   0
   </IfModule>

mod_fcgid configuration
---------------------------

QGIS Server runs fcgi mode. We must therefore configure the Apache mod_fcgid to suit to the server capabilities.

.. code-block:: bash

   # Open the mod_fcgid configuration file
   nano /etc/apache2/mods-enabled/fcgid.conf
   # Paste the following content and adapt it
   <IfModule mod_fcgid.c> 
     AddHandler    fcgid-script .fcgi
     FcgidConnectTimeout 300
     FcgidIOTimeout 300
     FcgidMaxProcessesPerClass 50
     FcgidMinProcessesPerClass 20
     FcgidMaxRequestsPerProcess 500
     IdleTimeout   300
     BusyTimeout   300
   </IfModule>


Restart Apache
------------------

You must restart the Apache server to validate the configuration.

.. code-block:: bash

   service apache2 restart


Spatial DBMS: PostgreSQL
============================================

It can be very interesting to use PostgreSQL and PostGIS to manage spatial data centralized manner on the server.

Install
-------------

.. code-block:: bash

   # Install packages
   apt-get install postgresql postgresql-contrib postgis pgtune php5-pgsql

   # A cluster is created in order to specify the storage directory
   mkdir /home/data
   mkdir /home/data/postgresql
   service postgresql stop
   pg_dropcluster --stop 9.1 main
   chown postgres:postgres /home/data/postgresql
   pg_createcluster 9.1 main -d /home/data/postgresql --locale fr_FR.UTF8 -p 5678 --start
   
   # Creating a "superuser" user
   su - postgres
   createuser myuser --superuser
   # Modifying passwords
   psql
   ALTER USER postgres WITH ENCRYPTED PASSWORD '************';
   ALTER USER myuser WITH ENCRYPTED PASSWORD '************';
   \q
   exit

Adapting the PostGreSQL configuration
----------------------------------------------

We will use pgtune, an utility program that can automatically generate a PostGreSQL configuration file adapted to the properties of the server (memory, processors, etc.)

.. code-block:: bash

   # PostgreSQL Tuning with pgtune
   pgtune -i /etc/postgresql/9.1/main/postgresql.conf -o /etc/postgresql/9.1/main/postgresql.conf.pgtune --type Web
   cp /etc/postgresql/9.1/main/postgresql.conf /etc/postgresql/9.1/main/postgresql.conf.backup
   cp /etc/postgresql/9.1/main/postgresql.conf.pgtune /etc/postgresql/9.1/main/postgresql.conf  
   nano /etc/postgresql/9.1/main/postgresql.conf
   # Restart to check any problems
   service postgresql restart
   # If error messages, increase the linux kernel configuration variables
   echo "kernel.shmall = 4294967296" >> /etc/sysctl.conf # pour shared_buffers à 3000Mo
   echo "kernel.shmmax = 4294967296" >> /etc/sysctl.conf
   echo 4294967296 > /proc/sys/kernel/shmall
   echo 4294967296 > /proc/sys/kernel/shmmax
   sysctl -a | sort | grep shm     
   # Restart PostGreSQL
   service postgresql restart


FTP Server: pure-ftpd
=======================

Install
---------------

.. code-block:: bash

   apt-get install pure-ftpd pure-ftpd-common
   
Configure
---------------

.. code-block:: bash

   # Creating an empty shell for users
   ln /bin/false /bin/ftponly
   # Configuring FTP server
   echo "/bin/ftponly" >> /etc/shells
   # Each user is locked in his home
   echo "yes" > /etc/pure-ftpd/conf/ChrootEveryone
   # Allow to use secure FTP over SSL
   echo "1" > /etc/pure-ftpd/conf/TLS
   # Configure the properties of directories and files created by users
   echo "133 022" > /etc/pure-ftpd/conf/Umask
   # The port range for passive mode (opening outwards)
   echo "5400 5600" > /etc/pure-ftpd/conf/PassivePortRange
   # Creating an SSL certificate for FTP
   openssl req -x509 -nodes -newkey rsa:1024 -keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem 
   chmod 400 /etc/ssl/private/pure-ftpd.pem
   # Restart FTP server
   service pure-ftpd restart 

Creating a user account
--------------------------------

.. code-block:: bash

   # Creating a user accountr
   MYUSER=demo
   useradd -g client -d /home/data/ftp/$MYUSER -s /bin/ftponly -m $MYUSER -k /home/data/ftp/template/
   passwd $MYUSER
   # Fix the user's FTP root
   chmod a-w /home/data/ftp/$MYUSER 
   # Creating empty directories that will be the future Lizmap Web Client directories
   mkdir /home/data/ftp/$MYUSER/qgis/rep1 && chown $MYUSER:client /home/data/ftp/$MYUSER/qgis/rep1
   mkdir /home/data/ftp/$MYUSER/qgis/rep2 && chown $MYUSER:client /home/data/ftp/$MYUSER/qgis/rep2
   mkdir /home/data/ftp/$MYUSER/qgis/rep3 && chown $MYUSER:client /home/data/ftp/$MYUSER/qgis/rep3
   mkdir /home/data/ftp/$MYUSER/qgis/rep4 && chown $MYUSER:client /home/data/ftp/$MYUSER/qgis/rep4
   mkdir /home/data/ftp/$MYUSER/qgis/rep5 && chown $MYUSER:client /home/data/ftp/$MYUSER/qgis/rep5
   # Create a directory to store the cached server
   mkdir /home/data/cache/$MYUSER
   chmod 700 /home/data/cache/$MYUSER -R
   chown www-data:www-data /home/data/cache/$MYUSER -R 


Map server: QGIS Server
====================================

Install
---------------

.. code-block:: bash

   # Add the repository UbuntuGis
   cat /etc/apt/sources.list.d/debian-gis.list
   deb http://qgis.org/debian trusty main
   deb-src http://qgis.org/debian trusty main
    
   # Add keys
   sudo gpg --recv-key DD45F6C3
   sudo gpg --export --armor DD45F6C3 | sudo apt-key add -
    
   # Update package list
   sudo apt-get update
   
   # Install QGIS Server
   sudo apt-get install qgis-server python-qgis

.. note:: See http://docs.qgis.org/testing/en/docs/user_manual/working_with_ogc/ogc_server_support.html to more information on QGIS Server.
