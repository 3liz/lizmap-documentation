========================
Log management in Lizmap
========================

.. contents::
   :depth: 3

Principle and description
=========================

Since version 2.8, you can configure *Lizmap Web Client* so that certain user actions are stored in a SQLite database:

* User Login
* Displaying a Lizmap map
* Printing a map
* Displaying a popup
* Using the editing tool

For each of these actions can be chosen:

* to record a new line in the logs containing various information: user, date and time, action, Lizmap repository, QGIS project, IP address
* to increment the counter for this action, the Lizmap repository and QGIS project.

Configure logs
==============

For now, it is not possible to change the configuration of logs in the administration interface. It is necessary to manually edit the configuration file **lizmap/var/config/lizmapLogConfig.ini.php**. This file is in *ini* format and contains many sections as action to save. For each action, you can choose to activate with *on* or off with *off* the recording of the log.

For example, the following section shows that the administrator has chosen to record a count in the logs every time a user connects. But he does not want to save the details for each connection.

.. code-block:: bash

   [item:login]
   label="User logs in"
   logCounter=on
   logDetail=off
   logIp=off

View logs
=========

To view logs, simply connect to the Lizmap administration interface as an administrator. Then the logs can be accessed through the menu **Lizmap Logs**. This page shows the general statistics on the 2 log tables: *Log count* and *Log detail*. For each, it is possible to:

* **View Tables** containing the raw data
* **Completely empty logs**: completly reset!

Log storage file
================

The log database is located here in relation to the installation directory: **lizmap/var/logs.db**. For example:

.. code-block:: bash

   # ifLizmap  Web Client is installed here : /var/www/lizmap-web-client-2.8.1/, the file is:
   /var/www/lizmap-web-client-2.8.1/lizmap/var/logs.db   

This database can be accessed with a Sqlite database reading tool, like *SQLite Browser* or the Firefox add-on *SQlite Manager*. If you know SQL, so you can make queries to extract information from the detailed logs.
