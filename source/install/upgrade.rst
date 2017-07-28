===============================================================
Upgrade Lizmap Web Client
===============================================================

Upgrading between 3.x versions
===============================================================

From 3.0 versions to upper, there is no need to backup data.

Simply replace lizmap files and call:

.. code-block:: bash

   sudo lizmap/install/clean_vartmp.sh
   php lizmap/install/installer.php
   sudo lizmap/install/clean_vartmp.sh

Upgrading to Lizmap 3.0
===============================================================

First, be sure that your lizmap installation has been upgraded to the latest version
of 2.x. The last one is 2.12.

Then you can upgrade to Lizmap 3.0.

Data backup
--------------------------------------------------------------

Backup your data into a directory (ex: /tmp).

Lizmap 2.12.2 and higher has a lizmap/install/backup.sh script. Call

.. code-block:: bash

   lizmap/install/backup.sh /tmp

If you don't have this script, backup by hand, copy these files somewhere, /tmp for instance:

- var/jauth.db
- var/logs.db
- var/config/lizmapConfig.ini.php
- var/config/installer.ini.php
- var/config/profiles.ini.php


Replace lizmap files
--------------------------------------------------------------

Get the lizmap archive (by downloading an archive or by doing a git clone/pull)

You should

- replace the lib/ directory by the new lib/ directory
- replace the lizmap/ directory by new lizmap/


Restore data and clean installation
--------------------------------------------------------------

Restore rights and owner on some directories. Here is an example where "myuser" is the
user owning the application file, and "www-data", the group of the web server.

.. code-block:: bash

   sudo lizmap/install/set_rights.sh www-data www-data
   sudo lizmap/install/clean_vartmp.sh

Then you can restore the backup, by giving the path where the backuped file where previously saved:

.. code-block:: bash

   lizmap/install/restore.sh /tmp


Note: Lizmap 3.0 requires that "*.db" files should be stored in var/db/, not in var/ as in 2.x


Last step: launch the upgrade script

.. code-block:: bash

   php lizmap/install/upgrade-to-3.php


Upgrading between 2.x versions
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

   $VERSION=2.10.3
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
