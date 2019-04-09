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

- var/jauth.db
- var/logs.db
- var/config/installer.ini.php
- var/config/liveConfig.ini.php (if it exists)
- var/config/lizmapConfig.ini.php
- var/config/localconfig.ini.php
- var/config/profiles.ini.php


Replace lizmap files
--------------------------------------------------------------

Get the lizmap archive (by downloading an archive or by doing a git clone/pull)

You should

- replace the lib/ directory by the new lib/ directory
- replace files into lizmap/ directory by the new lizmap/ files
- If the replacement has erased some files that you've been backuped, restore
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
   if you upgrade from 3.0 or 3.1 to Lizmap 3.2, and if you are using the ldap
   authentication with the ldapdao module, you have to know that this module
   is included into Lizmap 3.2 and is pre-configured. So, before launching the
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
