===============
Publish the map
===============

.. contents::
   :depth: 3

Reminder of Lizmap architecture
===============================

.. image:: /images/architecture.jpg
   :align: center





Duplicate local files to Lizmap repository 
==========================================


**Lizmap is based on repositories system**. To publish a map in Lizmap, it is sufficient to ensure that the contents of the local directory containing the data and QGIS projects **be reproduced exactly** identical in the corresponding server repository.

For this, it is necessary **to synchronize the local directory with that of the server** each time you update the QGIS project, modify the Lizmap configuration with the plugin, or add files in the local directory.

At least two files are required : the QGIS project file (.qgs) and the corresponding Lizmap configuration file (.qgs.cfg).

.. note:: If you are working locally, as Lizmap Web Client is installed on the same machine you use for QGIS, you do not need to *synchronize* your files. This configuration should only exist for testing.

.. note:: You can use any tool and synchronization protocol (FTP, FTPS, SFTP, rsync, unison, etc), if you can master the tool and have access to the Lizmap server configuration.
