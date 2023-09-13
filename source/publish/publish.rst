===============
Publish the map
===============

.. contents::
   :depth: 3

.. tip:: Reminder of Lizmap publication workflow, see :ref:`intro-lizmap-archi`.

File and folder organisation
----------------------------

**Lizmap is based on a repository system**. To publish a map in Lizmap, you must check that the contents of the local
directory containing the data and QGIS projects must **be reproduced identically** in the corresponding server
repository.

For this, it is necessary **to transfer the local directory with on the server** each time you update either the QGIS
project or the Lizmap configuration or any other files linked to the QGIS project.

At least two files are required : the QGIS project file (:file:`*.qgs`) and the corresponding Lizmap configuration file
(:file:`*.qgs.cfg`).

.. tip::
    Check how to transfer these files with your Lizmap server provider or how the system administrator have configured
    this step, see: :ref:`install-transfer-tool`.

Lizmap repository
-----------------

.. include:: shared/lizmap_repository.rst
