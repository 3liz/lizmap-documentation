===============================================================
Installing Lizmap Web CLient on Linux Debian or Ubuntu
===============================================================


Install
===============================================================

.. note:: Beforehand, you must have a server running Apache. We also consider that QGIS Server has been installed correctly. See: :ref:`server_configuration` or http://docs.qgis.org/testing/en/docs/user_manual/working_with_ogc/ogc_server_support.html

.. warning:: This page does not describe how to secure your Apache server.


Get libraries
--------------------------------------------------------------

.. code-block:: bash

   sudo su # only useful if you are not logged in as root
   apt-get update # update packages
   apt-get install apache2 php5 curl php5-curl php5-sqlite php5-pgsql php5-gd # installation of apache2, php, curl, gd, sqlite and pgsql
   service apache2 restart # restart Apache server

Go to the *www* default Apache directory (modify as needed).

.. code-block:: bash

   cd /var/www/

Retrieve and install Lizmap Web Client
--------------------------------------------------------------

With ZIP file
~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   cd /var/www/
   # Options
   MYAPP=lizmap-web-client
   VERSION=2.12.2
   # Archive recovery with wget
   wget https://github.com/3liz/$MYAPP/archive/$VERSION.zip
   # Unzip archive
   unzip $VERSION.zip
   # virtual link for http://localhost/lm
   ln -s /var/www/$MYAPP-$VERSION/lizmap/www/ /var/www/html/lm
   # Remove archive
   rm $VERSION.zip

Development version with git
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. warning:: the development version is always changing, and bugs can occur. Do not use it in production.

* The first time

.. code-block:: bash

   cd /var/www/
   MYAPP=lizmap-web-client
   VERSION=master
   # Clone the master branch
   git clone https://github.com/3liz/lizmap-web-client.git $MYAPP-$VERSION
   # Go into the git repository
   cd $MYAPP-$VERSION
   # Create a personal branch for your changes
   git checkout -b mybranch

* To update your branch from the master repository

.. code-block:: bash

   cd /var/www/$MYAPP-$VERSION
   # Check that you are on the branch: mybranch
   git checkout mybranch

   # If you have any changes, make a commit
   git status
   git commit -am "Your commit message"

   # Save your configuration files!
   cp lizmap/var/jauth.db /tmp/jauth.db && cp lizmap/var/logs.db /tmp/logs.db && cp lizmap/var/config/lizmapConfig.ini.php /tmp/lizmapConfig.ini.php

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

   cd /var/www/$MYAPP-$VERSION
   chown :www-data temp/ lizmap/var/ lizmap/www lizmap/install/qgis/edition/ -R
   chmod 775 temp/ lizmap/var/ lizmap/www lizmap/install/qgis/edition/ -R

First test
--------------------------------------------------------------

Go to the Lizmap Web Client home to see if the installation was performed correctly: http://localhost/lm

Editing tool: Configure the server with the database support
=============================================================================

PostGreSQL
------------------------------

For the editing of PostGIS layers in Web Client Lizmap operate, install PostgreSQL support for PHP.

.. code-block:: bash

   sudo apt-get install php5-pgsql
   sudo service apache2 restart

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

So that Lizmap Web Client can modify the data contained in databases Spatialite, we must ensure that **the Apache user (www-data) has well write access to the directory containing each Spatialite file**

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


Version upgrade
===============================================================

Preliminary backup
--------------------------------------------------------------

Before update, make a backup of the configuration data: *lizmap/var/config/lizmapConfig.ini.php*, *lizmap/var/jauth.db* and the log file (from 2.8) *lizmap/var/logs.db*

.. code-block:: bash

   MYAPP=lizmap-web-client
   OLDVERSION=2.8.1 # replace by the version number of your current lizmap installation
   # if you installation is 2.1.0 or less, use an empty OLDVERSION instead :
   # OLDVERSION=
   cp /var/www/$MYAPP-$OLDVERSION/lizmap/var/jauth.db /tmp/jauth.db # user database
   cp /var/www/$MYAPP-$OLDVERSION/lizmap/var/config/lizmapConfig.ini.php /tmp/lizmapConfig.ini.php # text configuration file with services and repositories
   cp /var/www/$MYAPP-$OLDVERSION/lizmap/var/logs.db /tmp/logs.db # lizmap logs

Then do a typical installation of the new version (see above), which will create a new folder in the directory */var/www/*


Copy the files saved in the folder of the new version
-----------------------------------------------------------------------

.. code-block:: bash

   $VERSION=2.12.2
   cp /tmp/jauth.db /var/www/$MYAPP-$VERSION/lizmap/var/jauth.db
   cp /tmp/lizmapConfig.ini.php /var/www/$MYAPP-$VERSION/lizmap/var/config/lizmapConfig.ini.php
   cp /tmp/logs.db /var/www/$MYAPP-$VERSION/lizmap/var/logs.db

.. note:: In some versions, it is also necessary to update the database that stores the rights. See the following for more details.

From version 2.3 or lower to version 2.4 or upper
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Jelix framework (tool with which Lizmap Web Client is built) has been updated. It is necessary to change the rights management SQLite database:

.. code-block:: bash

   cd /var/www/$MYAPP-$VERSION/
   sqlite3 lizmap/var/jauth.db < lizmap/install/sql/upgrade_jacl2db_1.3_1.4.sql

From version 2.6 or lower to version 2.7
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Support for annotations and management of related rights was added to Lizmap Web Client. It is necessary to change the rights management SQLite database to upgrade it:

.. code-block:: bash

   cd /var/www/$MYAPP-$VERSION/
   sqlite3 lizmap/var/jauth.db < lizmap/install/sql/upgrade_jacl2db_lizmap_from_2.0_and_above_to_2.5.sql


From version 2.7.*  to version 2.8
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The editing tool replaced the annotation tool and fields to describe each Lizmap Web Client user has been added. It is necessary to upgrade the rights management SQLite database:

.. code-block:: bash

   cd /var/www/$MYAPP-$VERSION/
   sqlite3 lizmap/var/jauth.db < lizmap/install/sql/upgrade_jacl2db_2.7_2.8.sql

From version 2.8.*  to version 2.9
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The functionality of layers data filtering based on the connected user requires the addition of rights related to the user data base:

.. code-block:: bash

   cd /var/www/$MYAPP-$VERSION/
   sqlite3 lizmap/var/jauth.db < lizmap/install/sql/upgrade_jacl2db_2.8_2.9.sql

From version 2.9.*  to version 2.10
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The functionality of layers data filtering based on the connected user requires the addition of rights related to the user data base:

.. code-block:: bash

   cd /var/www/$MYAPP-$VERSION/
   sqlite3 lizmap/var/jauth.db < lizmap/install/sql/upgrade_jacl2db_2.9_2.10.sql

Delete Jelix temporary files
--------------------------------------------------------------

.. code-block:: bash

   rm -rf /var/www/$MYAPP-$VERSION/temp/lizmap/*

Redefine the rights to the application files
-------------------------------------------------------

.. code-block:: bash

   cd /var/www/$MYAPP-$VERSION
   chown :www-data temp/ lizmap/var/ lizmap/www lizmap/install/qgis/edition/ -R
   chmod 775 temp/ lizmap/var/ lizmap/www lizmap/install/qgis/edition/ -R
