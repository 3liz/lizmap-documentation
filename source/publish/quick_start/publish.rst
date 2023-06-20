===============
Publish the map
===============

.. contents::
   :depth: 3

.. note:: Reminder of Lizmap publication wokflow, see :ref:`intro-lizmap-archi`


**Lizmap is based on repositories system**. To publish a map in Lizmap, it is sufficient to ensure that the contents of the local directory containing the data and QGIS projects **be reproduced exactly** identical in the corresponding server repository.

For this, it is necessary **to synchronize the local directory with that of the server** each time you update the QGIS project, modify the Lizmap configuration with the plugin, or add files in the local directory.

At least two files are required : the QGIS project file (.qgs) and the corresponding Lizmap configuration file (.qgs.cfg).

See the set-up chosen by admin during installation : :ref:`install-sync-tool`