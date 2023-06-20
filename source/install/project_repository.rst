
.. _install-sync-tool:

==============================================
Add an access for synchronizing projects files
==============================================

.. note:: If you are working locally, as Lizmap Web Client is installed on the same machine you use for QGIS, you do not need to *synchronize* your files. This configuration should only exist for testing.

Once your Lizmap is working correctly, you need to setup some workflow to allow publishers to synchronize their projects files (.qgs, .qgs.cfg) on the server.
Precisly, you need to grant an acces to the folder you defined during installation (:ref:`install-data-folder`) and setup in administration (:ref:`declare-repositories`).

You can use any tool and synchronization protocol (FTP, FTPS, SFTP, DAV, rsync, unison, etc). The folder must be accessible for lizmap and qgis process (which read the project files) and your synchronisation set-up (ftp user, rsync process, ...).