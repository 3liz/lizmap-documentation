======================
Publish the map by FTP
======================

.. contents::
   :depth: 3

Reminder of Lizmap architecture
===============================

.. image:: /images/architecture.jpg
   :align: center

**Lizmap is based on repositories system**. To publish a map in Lizmap, it is sufficient to ensure that the contents of the local directory containing the data and QGIS projects **be reproduced exactly** identical in the corresponding server repository.

For this, it is necessary **to synchronize the local directory with that of the server** each time you update the QGIS project, modify the Lizmap configuration with the plugin, or add files in the local directory.

.. note:: If you are working locally, as Lizmap Web Client is installed on the same machine you use for QGIS, you do not need to *synchronize* your files with FTP. This configuration should only exist for testing.

.. note:: You can use any tool and synchronization protocol (FTP, FTPS, SFTP, rsync, unison, etc), if you can master the tool and have access to the Lizmap server configuration.


Use an FTP client
=================

FTP allows you to access files from a server, retrieve it and add documents and/or folders. It can therefore be used to synchronize your local directory with the server one Where Lizmap Web Client is on. This protocol is a Web standard that can be exploited through many FTP clients.

You can use the following client or one you usually use:

* *FireFTP*: Firefox add-on
* *Filezilla*: Free cross-platform software (Windows, MacOS, Linux)
* *WinSCP*: Free software for Windows

You can use these tools to make manual changes to the remote directory:

* **made a backup**
* **remove contents**
* **overwrite files manually**: QGIS project :file:`*.qgs` and Lizmap configuration :file:`*.qgs.cfg`.
