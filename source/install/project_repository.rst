.. _install-transfer-tool:

============================
Transfer files to the server
============================

Once your Lizmap is working correctly, you need to setup some workflow to allow publishers to transfer their projects
files (:file:`*.qgs`, :file:`*.qgs.cfg`…) on the server.
Precisely, you need to grant an access to the folder you defined during the installation (:ref:`install-data-folder`)
and defined in the administration panel (:ref:`declare-repositories`).

You can use any tool you want (DAV, rsync, unison, etc). The folder must be accessible for Lizmap and QGIS processes
(which read project files).

.. note::
    If you have installed Lizmap Web Client on your machine, where QGIS Desktop is running as well, you do not need to
    *transfer* your files. This configuration should only exist for testing.
