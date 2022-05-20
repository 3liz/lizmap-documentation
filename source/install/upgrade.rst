===============================================================
Upgrade Lizmap Web Client
===============================================================

Upgrading from Lizmap 2.x
===============================================================

See `documentation of Lizmap 3.1 <https://docs.lizmap.com/3.1/en/install/upgrade.html>`_.

Upgrading from Lizmap 3.x versions
===============================================================

From 3.0 versions to upper, here is how to upgrade.

Data backup
--------------------------------------------------------------

Backup your data into a directory (ex: /tmp) with the lizmap/install/backup.sh
script, so you could reinstall them if the installation failed.

.. code-block:: bash

   lizmap/install/backup.sh /tmp

If you want to backup by hand, you should backup at least these files:

- var/db/jauth.db
- var/db/logs.db
- var/config/installer.ini.php
- var/config/liveConfig.ini.php (if it exists)
- var/config/lizmapConfig.ini.php
- var/config/localconfig.ini.php
- var/config/profiles.ini.php


Replace Lizmap files
--------------------------------------------------------------

Get the Lizmap archive by downloading an archive on the `release <https://github.com/3liz/lizmap-web-client/releases>`_ page.

You should :

- replace the ``lib/`` directory by the new ``lib/`` directory
- replace files into ``lizmap/`` directory by the new ``lizmap/`` files
- If the replacement has erased some files that you've been done any backup, restore
  them with ``lizmap/install/restore.sh /tmp``

Launch the installer
--------------------------------------------------------------

You have to launch the installer, it will upgrade some stuff: database tables,
configuration etc..

.. code-block:: bash

   sudo lizmap/install/clean_vartmp.sh
   php lizmap/install/installer.php
   sudo lizmap/install/clean_vartmp.sh

.. note::
   if you upgrade from 3.0 or 3.1 to Lizmap 3.2/3.3, and if you are using the ldap
   authentication with the ldapdao module, you have to know that this module
   is included into Lizmap 3.2/3.3 and is pre-configured. So, before launching the
   installer, you have to remove the ldapdao module you've installed, and you
   have to configure the ldapdao module in a little different manner than when
   installing it by hand. See the ldap configuration section in this manual.


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


Migrating from Sqlite to Postgresql
-----------------------------------

You may have installed Lizmap with Sqlite. You should then have these files
:file:`lizmap/var/db/jauth.db` and :file:`lizmap/var/db/logs.db`, where
some data like users, permissions and logs are stored. And you should
have this configuration into :file:`lizmap/var/config/profiles.ini.php`:


.. code-block:: ini

    [jdb:jauth]
    driver=sqlite3
    database="var:db/jauth.db"

    [jdb:lizlog]
    driver=sqlite3
    database="var:db/logs.db"

It you have a such configuration, you can migrate data to a Postgresql database.

First, create a Postgresql database, and then change the configuration into
:file:`lizmap/var/config/profiles.ini.php`, by setting access parameters to
the Postgresql database. It is recommended to create a schema into the database,
for example ``lizmap`` , if it contains already some tables.


For example :

.. code-block:: ini

    [jdb:jauth]
    driver=pgsql
    host=localhost
    port=5432
    database="your_database"
    user=my_login
    password=my_password
    search_path=lizmap,public

    [jdb:lizlog]
    driver=pgsql
    host=localhost
    port=5432
    database="your_database"
    user=my_login
    password=my_password
    search_path=lizmap,public

See the chapter about installation to know more about these parameters.

Then you can launch these scripts which will migrate the data.


.. code-block:: bash

    php lizmap/scripts/script.php lizmap~database:migrateusers
    php lizmap/scripts/script.php lizmap~database:migratelog

If there are no errors, you can then go onto lizmap with your browser, and
check that you can authenticate yourself. You should see also the list of
users into the administration panel. If this is the case, you can backup files jauth.db
and logs.db and you can delete them.

If something goes wrong and you cannot fix the issue, revert the database access
into :file:`lizmap/var/config/profiles.ini.php` as before, like this :


.. code-block:: ini

    [jdb:jauth]
    driver=sqlite3
    database="var:db/jauth.db"

    [jdb:lizlog]
    driver=sqlite3
    database="var:db/logs.db"

And Lizmap should work well, but still with Sqlite.
