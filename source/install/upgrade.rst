===============================================================
Upgrade Lizmap Web Client
===============================================================

Upgrading from Lizmap 2.x
===============================================================

See `documentation of Lizmap 3.1 <https://docs.lizmap.com/3.1/en/install/upgrade.html>`_.

Upgrading from Lizmap lower than 3.5 versions
=============================================

You should first migrate to 3.5. See `documentation of Lizmap 3.5 <https://docs.lizmap.com/3.5/en/install/upgrade.html>`_.
Then you could migrate to 3.6

Upgrading from Lizmap 3.5 version
=================================

Here is how to upgrade from Lizmap 3.5.

Data backup
--------------------------------------------------------------

Backup your data and configuration files into a directory (ex: ``/tmp``) with the ``lizmap/install/backup.sh``
script of Lizmap 3.5.

.. code-block:: bash

   lizmap/install/backup.sh /tmp

If you want to backup by hand, you should backup at least these files:

- var/db/jauth.db (if it exists)
- var/db/logs.db (if it exists)
- var/config/installer.ini.php
- var/config/liveConfig.ini.php
- var/config/localframework.ini.php (if it exists)
- var/config/lizmapConfig.ini.php
- var/config/localconfig.ini.php
- var/config/profiles.ini.php


Replace Lizmap files
--------------------------------------------------------------

Get the Lizmap archive by downloading an archive on the `release <https://github.com/3liz/lizmap-web-client/releases>`_ page.

You should then :

- rename the ``lizmap/`` directory to ``lizmap.bak/`` for example
- extract the ``lizmap/`` directory from the archive, so it will be become the new ``lizmap/`` directory.
- execute the script ``lizmap/install/restore.sh /tmp`` or reinstall by hand the files you backup.

Note: there is not anymore a ``lib/`` directory.

Launch the installer
--------------------------------------------------------------

You have to launch the configurator (it will upgrade some configuration files),
and then the installer, which will upgrade some stuff: database tables, data etc..

.. code-block:: bash

   sudo lizmap/install/clean_vartmp.sh
   php lizmap/install/configurator.php
   php lizmap/install/installer.php


Cleanup and test
----------------------------------------------------------------

You should then delete all cache and temporary files:

.. code-block:: bash

   sudo lizmap/install/clean_vartmp.sh

Then you should call the script that sets rights on files. Parameters are the
web user and the web group used by the web server to execute Lizmap. On a
Debian server, it is often www-data.

.. code-block:: bash

    sudo lizmap/install/set_rights.sh www-data www-data


Then load Lizmap into your browser, you should see your maps without errors.

If this is the case, you can delete the old directories ``lib/`` and ``lizmap.bak/``.


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
