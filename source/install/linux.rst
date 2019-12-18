===============================================================
Installing Lizmap Web Client on Linux Debian or Ubuntu
===============================================================

Generic Server Configuration
===============================================================

This documentation provides an example for configuring a server with the Debian 9 distribution. We assume you have base system installed and updated.

.. warning:: This page does not describe how to secure your Nginx server. It's just for a demonstration.

Configure Locales
--------------------------------------------------------------

For simplicity, it is interesting to configure the server with UTF-8 default encoding.

.. code-block:: bash

   # configure locales
   locale-gen fr_FR.UTF-8 #replace fr with your language
   dpkg-reconfigure locales
   # define your timezone [useful for logs]
   dpkg-reconfigure tzdata
   apt install ntp ntpdate

.. note:: It is also necessary configure the other software so that they are using this default encoding if this is not the case.

Installing necessary packages
-----------------------------

.. warning:: Lizmap web client is based on Jelix 1.6. You must install at least the **5.6** version of PHP. The **dom**, **simplexml**, **pcre**, **session**, **tokenizer** and **spl** extensions are required (they are generally turned on in a standard PHP 5.6/7.x installation)

.. code-block:: bash

   sudo su # only necessary if you are not logged in as root
   apt update # update package lists
   apt-get install curl openssl libssl1.1 nginx-full nginx nginx-common

On debian 9, install these packages:

.. code-block:: bash

   apt-get install php7.0-fpm php7.0-cli php7.0-bz2 php7.0-curl php7.0-gd php7.0-intl php7.0-json php7.0-mbstring php7.0-pgsql php7.0-sqlite3 php7.0-xml php7.0-ldap

On Ubuntu 18.04 or later, install these packages:

.. code-block:: bash

   apt-get install php7.3-fpm php7.3-cli php7.3-bz2 php7.3-curl php7.3-gd php7.3-intl php7.3-json php7.3-mbstring php7.3-pgsql php7.3-sqlite3 php7.3-xml php7.3-ldap

Web configuration
-----------------------

Create a new file /etc/nginx/sites-available/lizmap.conf:

.. code-block:: nginx

    server {
        listen 80;

        server_name localhost;
        root /var/www/html/lizmap;
        index index.php index.html index.htm;

        # compression setting
        gzip_vary on;
        gzip_proxied any;
        gzip_comp_level 5;
        gzip_min_length 100;
        gzip_http_version 1.1;
        gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript text/json;

        location / {
            try_files $uri $uri/ =404;
        }

        location ~ [^/]\.php(/|$) {
           fastcgi_split_path_info ^(.+\.php)(/.*)$;
           set $path_info $fastcgi_path_info; # because of bug http://trac.nginx.org/nginx/ticket/321
           try_files $fastcgi_script_name =404;
           include fastcgi_params;

           fastcgi_index index.php;
           fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
           fastcgi_param PATH_INFO $path_info;
           fastcgi_param PATH_TRANSLATED $document_root$path_info;
           fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
           fastcgi_param SERVER_NAME $http_host;
        }
    }

You should declare the lizmap.local domain name somewhere (in your /etc/hosts,
or into your DNS..), or replace it by your own domain name.

Enable the virtual host you just created:

.. code-block:: bash

   ln -s /etc/nginx/sites-available/lizmap.conf /etc/nginx/sites-enabled/lizmap.conf

Enable geolocation
-------------------

The automatic geolocation provided by Lizmap relies on Google services. To enable it, your webGIS must be placed under a secure protocol, like HTTPS. See for more details:

https://sites.google.com/a/chromium.org/dev/Home/chromium-security/deprecating-powerful-features-on-insecure-origins

https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-apache-in-ubuntu-16-04

Restart Nginx
--------------

You must restart the Nginx server to validate the configuration.

.. code-block:: bash

   service nginx restart

Create directories for data
============================================

Qgis files and other cache files will be stored into these directories.

.. code-block:: bash

   mkdir /home/data
   mkdir /home/data/cache/
  # optional
   mkdir /home/data/ftp
   mkdir /home/data/ftp/template/
   mkdir /home/data/ftp/template/qgis

Spatial DBMS: PostgreSQL
============================================

.. note:: This section is optional

PostgreSQL and PostGIS can be very useful to manage spatial data centralized manner on the server.

Install
-------------

.. code-block:: bash

   # Install packages
   apt-get install postgresql postgresql-contrib postgis pgtune

   # A cluster is created in order to specify the storage directory
   mkdir /home/data/postgresql
   service postgresql stop
   pg_dropcluster --stop 9.6 main
   chown postgres:postgres /home/data/postgresql
   pg_createcluster 9.6 main -d /home/data/postgresql --locale fr_FR.UTF8 -p 5678 --start

   # Creating a "superuser" user
   su - postgres
   createuser myuser --superuser
   # Modifying passwords
   psql
   ALTER USER postgres WITH ENCRYPTED PASSWORD '************';
   ALTER USER myuser WITH ENCRYPTED PASSWORD '************';
   \q
   exit

Adapting the PostgreSQL configuration
----------------------------------------------

We will use pgtune, an utility program that can automatically generate a PostgreSQL configuration file adapted to the properties of the server (memory, processors, etc.)

.. code-block:: bash

   # PostgreSQL Tuning with pgtune
   pgtune -i /etc/postgresql/9.6/main/postgresql.conf -o /etc/postgresql/9.6/main/postgresql.conf.pgtune --type Web
   cp /etc/postgresql/9.6/main/postgresql.conf /etc/postgresql/9.6/main/postgresql.conf.backup
   cp /etc/postgresql/9.6/main/postgresql.conf.pgtune /etc/postgresql/9.6/main/postgresql.conf
   nano /etc/postgresql/9.6/main/postgresql.conf
   # Restart to check any problems
   service postgresql restart
   # If error messages, increase the linux kernel configuration variables
   echo "kernel.shmall = 4294967296" >> /etc/sysctl.conf # to increas shred buffer param in kernel
   echo "kernel.shmmax = 4294967296" >> /etc/sysctl.conf
   echo 4294967296 > /proc/sys/kernel/shmall
   echo 4294967296 > /proc/sys/kernel/shmmax
   sysctl -a | sort | grep shm
   # Restart PostgreSQL
   service postgresql restart

FTP Server: pure-ftpd
=======================

.. note:: This section is optional

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

.. note:: Details for the installation may differ for specific versions of the operating system. Please refer to http://qgis.org/en/site/forusers/download.html for up to date documentation.

First declare the QGIS repository into a  /etc/apt/sources.list.d/debian-qgis.list file. Its content should be:

.. code-block:: text

    deb http://qgis.org/debian-ltr stretch main


Install also the Qgis key for the package manager

.. code-block:: bash

   # Add keys
   sudo gpg --recv-key CAEB3DC3BDF7FB45
   sudo gpg --export --armor CAEB3DC3BDF7FB45 | sudo apt-key add -


Update the package repository and install the Qgis packages:


.. code-block:: bash

   # Update package list
   sudo apt-get update

   # Install QGIS Server
   sudo apt-get install qgis-server python-qgis

.. note:: See https://docs.qgis.org/testing/en/docs/user_manual/working_with_ogc/server/index.html for more information on QGIS Server.

Retrieve and install Lizmap Web Client
=======================================

.. code-block:: bash

   cd /var/www/

With ZIP file
--------------

Retrieve the latest available stable version from https://github.com/3liz/lizmap-web-client/releases/

.. code-block:: bash

   cd /var/www/
   # Options
   VERSION=3.3.0
   # Archive recovery with wget
   wget https://github.com/3liz/lizmap-web-client/archive/$VERSION.zip
   # Unzip archive
   unzip $VERSION.zip
   # virtual link for http://localhost/lizmap/
   ln -s /var/www/lizmap-web-client-$VERSION/lizmap/www/ /var/www/html/lizmap
   # Remove archive
   rm $VERSION.zip


Set rights for Nginx, so php scripts could write some temporary files or do changes.

.. code-block:: bash

   cd /var/www/lizmap-web-client-$VERSION/
   lizmap/install/set_rights.sh www-data www-data


Create lizmapConfig.ini.php, localconfig.ini.php and profiles.ini.php and edit them
to set parameters specific to your installation. You can modify lizmapConfig.ini.php
to set the url of qgis map server and other things, and profiles.ini.php to store
data in a database other than an sqlite database.

.. code-block:: bash

   cd lizmap/var/config
   cp lizmapConfig.ini.php.dist lizmapConfig.ini.php
   cp localconfig.ini.php.dist localconfig.ini.php
   cp profiles.ini.php.dist profiles.ini.php
   cd ../../..

In case you want to enable the demo repositories, just add to ``localconfig.ini.php`` the following:

.. code-block:: bash

   [modules]
   lizmap.installparam=demo


Then you can launch the installer

.. code-block:: bash

   php lizmap/install/installer.php


For testing launch: ``http://127.0.0.1/lizmap`` in your browser.

In case you get a ``500 - internal server error``, run again:

.. code-block:: bash

   cd /var/www/lizmap-web-client-$VERSION/
   lizmap/install/set_rights.sh www-data www-data


Development version with git
----------------------------

.. warning:: The development version is always changing, and bugs can occur. Do not use it in production.

* The first time

.. code-block:: bash

   apt-get install git
   cd /var/www/
   VERSION=master
   # Clone the master branch
   git clone https://github.com/3liz/lizmap-web-client.git lizmap-web-client-$VERSION
   # Go into the git repository
   cd lizmap-web-client-$VERSION
   # Create a personal branch for your changes
   git checkout -b mybranch

* To update your branch from the master repository

.. code-block:: bash

   cd /var/www/lizmap-web-client-$VERSION
   # Check that you are on the branch: mybranch
   git checkout mybranch

   # If you have any changes, make a commit
   git status
   git commit -am "Your commit message"

   # Save your configuration files!
   lizmap/install/backup.sh /tmp

   # Update your master branch
   git checkout master && git fetch origin && git merge origin/master
   # Apply to your branch, marge and manage potential conflicts
   git checkout mybranch && git merge master
   # Apply rights
   chown :www-data temp/ lizmap/var/ lizmap/www lizmap/install/qgis/edition/ -R
   chmod 775 temp/ lizmap/var/ lizmap/www lizmap/install/qgis/edition/ -R

.. note:: It is always good to make a backup before updating.

Give the appropriate rights to directories and files
--------------------------------------------------------------

.. code-block:: bash

   cd /var/www/lizmap-web-client-$VERSION
   chown :www-data temp/ lizmap/var/ lizmap/www lizmap/install/qgis/edition/ -R
   chmod 775 temp/ lizmap/var/ lizmap/www lizmap/install/qgis/edition/ -R

First test
--------------------------------------------------------------

Go to the Lizmap Web Client home to see if the installation was performed correctly: http://localhost/lizmap

.. note:: Replace ``localhost`` with the address or IP number of your server.

Lizmap is accessible, without further configurations, also as WMS and WFS server from a browser:

http://localhost/lizmap/index.php/lizmap/service/?repository=montpellier&project=montpellier&VERSION=1.3.0&SERVICE=WMS&REQUEST=GetCapabilities

http://localhost/lizmap/index.php/lizmap/service/?repository=montpellier&project=montpellier&SERVICE=WFS&REQUEST=GetCapabilities

and from QGIS:

http://localhost/lizmap/index.php/lizmap/service/?repository=montpellier&project=montpellier&VERSION=1.3.0&

http://localhost/lizmap/index.php/lizmap/service/?repository=montpellier&project=montpellier&

.. note:: Access to the WMS and WFS servers can be limited by assigning privileges to specific repositories, see the administration section.


Editing tool: Configure the server with the database support
=============================================================================

.. note:: This section is optional

PostgreSQL
------------------------------

For the editing of PostGIS layers in Web Client Lizmap operate, install PostgreSQL support for PHP.

.. code-block:: bash

   sudo apt-get install php7.0-pgsql
   sudo service nginx restart

.. note:: For editing, we strongly recommend using a PostgreSQL database. This greatly simplifies installation and retrieval of data entered by users.

Spatialite
------------------------------

Enable Spatialite extension
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To use editing on layers spatiatlite,you have to add the spatialite extension in PHP. You can follow these instructions to do so:
http://www.gaia-gis.it/spatialite-2.4.0-4/splite-php.html

Lizmap Web Client tests whether the spatialite support is enabled in PHP. If it is not, then spatialities layers will not be used in the editing tool. You can always use PostgreSQL data for editing.

Give the appropriate rights to the directory containing Spatialite databases
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

So that Lizmap Web Client can modify the data contained in databases Spatialite, we must ensure that **the webserver user (www-data) has well write access to the directory containing each Spatialite file**

For example, if a directory contains a QGIS project, which uses a Spatialite database placed in a **db** directory at the same level as the QGIS project:

.. code-block:: bash

   /path/to/a/lizmap_directory
   |--- mon_projet.qgs
   |--- bdd
      |--- my_spatialite_file.sqlite

So you have to give the rights in this way:

.. code-block:: bash

   chown :www-data /path/to/a/lizmap_directory -R
   chmod 775 /path/to/a/lizmap_directory -R

.. note:: so if you want to install Lizmap to provide access to multiple map publishers, you should tell them to always create a **db** directory at the same level as the QGIS projects in the Lizmap Web Client directory. This will facilitate the admin work that just have to change the rights of this unique directory.
