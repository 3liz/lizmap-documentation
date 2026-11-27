===============================================================
Upgrade Lizmap Web Client
===============================================================

Upgrading from Lizmap 2.x
===============================================================

See `documentation of Lizmap 3.1 <https://docs.lizmap.com/3.1/en/install/upgrade.html>`_.

Upgrading from Lizmap lower than 3.5 versions
=============================================

You should first migrate to 3.5. See `documentation of Lizmap 3.5 <https://docs.lizmap.com/3.5/en/install/upgrade.html>`_.

.. _upgrade-3-10:

Upgrading to Lizmap 3.10
========================

Before upgrading to Lizmap 3.10, check these points:

* **PHP 8.2** is now the minimum version. Upgrade PHP first if needed, read :ref:`Installing necessary packages <linux-php-packages>`.
* **QGIS Server 3.40** is now the minimum version.
* Lizmap configuration files with a target version lower than **3.7** are not displayed anymore on the landing page.
  They are still listed in the administration panel with a warning. Open them with a recent version of the Lizmap
  plugin in QGIS desktop and save them again.

The upgrade itself is done with the usual steps described below (backup, replace files, launch the installer).

After the upgrade:

* The storage format of the **tile cache** has changed: the cache directory, or the Sqlite file, of a layer is now
  named with a hash of the layer name. A cache generated before the upgrade is not used anymore. You must
  **generate the cache again** (read :ref:`seed-cache`). The old cache is not deleted automatically: you can remove it
  with the command ``php lizmap/console.php wmts:cache:clean repository project``, which removes the whole cache
  of a project, or remove the old directories by hand.
* Tiles in **WebP** format are now stored as WebP in the cache (they were stored as JPEG before). If some layers use
  the WebP format with the server cache, clear their cache.
* The installer creates a new ``permalink`` table, used to store short permalinks (read :ref:`short-permalink`),
  and a new right :guilabel:`Manage server side permalinks` for administrators.
* The user interface now uses **Bootstrap 5** instead of Bootstrap 2. If you have written your own JavaScript, CSS
  themes or templates, check them, read :ref:`adding-javascript` and :ref:`creating-simple-themes`.
* For developers of additional modules, some old PHP classes have been removed: ``lizmapRepository`` (use
  ``\Lizmap\Project\Repository``), ``lizmapOGCRequest`` (use ``\Lizmap\Request\OGCRequest``), ``lizmapProxy``
  (use ``\Lizmap\Request\Proxy``), ``qgisServer`` and ``qgisProject``. The classes ``lizmapProject`` (use
  ``\Lizmap\Project\Project``) and ``lizmapWkt`` (use ``\Lizmap\App\WktTools``) are deprecated.

Upgrading from Lizmap 3.5 or 3.6 version
========================================

Here is how to upgrade.

First, you must install PHP and Composer (`apt install composer` in Debian, or install by hand from https://getcomposer.org ).
Then you can start the migration.

Install new sources of Lizmap.
------------------------------

Get the Lizmap archive by downloading an archive on the `release <https://github.com/3liz/lizmap-web-client/releases>`_ page.

You should then :

- rename the ``lizmap-web-client/`` directory to ``lizmap-web-client.bak/`` for example
- extract files from the archive and rename the ``lizmap-web-client-3.10.0`` directory to ``lizmap-web-client/``, so it
  replaces the previous installation.

.. code-block:: bash

    mv lizmap-web-client lizmap-web-client.bak
    zip -r lizmap-web-client-3.10.0.zip
    mv lizmap-web-client-3.10.0 lizmap-web-client


Migration
----------

Go into the ``lizmap-web-client/lizmap/install/`` directory and execute ``migrate_from_previous_version.sh``.
You must give the path of the old lizmap directory.


.. code-block:: bash

    cd lizmap-web-client/lizmap/install/
    migrate_from_previous_version.sh ../../../lizmap-web-client.bak/lizmap/

It will copy all configuration files and additionnal modules from the old installation, and update these modules.

Launch the installer
--------------------------------------------------------------

You have to launch the installer, which will upgrade some stuff: database tables, data etc..
You should stay in the ``lizmap-web-client/lizmap/install/`` directory.

.. code-block:: bash

   sudo clean_vartmp.sh
   php configurator.php
   php installer.php


Cleanup and test
----------------------------------------------------------------

You should then delete all cache and temporary files:

.. code-block:: bash

   sudo clean_vartmp.sh

Then you should call the script that sets rights on files. Parameters are the
web user and the web group used by the web server to execute Lizmap. On a
Debian server, it is often www-data.

.. code-block:: bash

    sudo set_rights.sh www-data www-data

Then load Lizmap into your browser, you should see your maps without errors.

Revert upgrade
---------------------------------------------------------------

If the new installation does not work, you can restore the old installation, by simply rename the
 ``lizmap-web-client.bak/`` to ``lizmap-web-client/``

.. code-block:: bash

    mv lizmap-web-client lizmap-web-client.newbug
    mv lizmap-web-client.bak lizmap-web-client


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

    php lizmap/console.php database:migrateusers
    php lizmap/console.php database:migratelog

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
