.. include:: ../../substitutions.rst

.. _edition:

Edition
=======

Principle
---------

It is possible to allow users to **edit spatial and attribute data** from the Lizmap Web Client interface for **PostgreSQL or Spatialite** layers of the QGIS project. The Lizmap plugin allows you to add one or more layers and choose what actions for each will be possible in the web interface:

* creating elements
* modifying attributes
* modifying the geometry
* deleting elements

The **Web form** presented to the user to populate the **attribute table** supports **editing tools** available in the *fields* tab of the QGIS Vector *layer properties*. You can configure a dropdown, hide a column, make it non-editable, use a check box, a text area, etc. All configuration is done with the mouse, in QGIS and the Lizmap plugin.

In addition, Lizmap Web Client automatically detects the column type (integer, real, string, etc.) and adds the necessary checks and controls on the fields.

Examples
--------

* **A town** wish that citizens identify visible problems on the road: uncollected trash, broken street lights, wrecks to remove. The QGIS project administrator creates a layer dedicated to collect data and displays them to all.

* **An engineering office** wants to allow project partners to trace remarks on the project areas. It allows the addition of polygons in a dedicated layer.

Prerequisites
-------------

To allow data editing in Lizmap Web Client, you must:

* Have vector layer with PostGIS or Spatialite.
* Configure the editing tool for the layer in :menuselection:`Layer Properties --> Attributs Form`. This is not required but recommended to control the data entered by users. See :ref:`form`.
* |wfs_layer|
* Despite we want to edit the layer, there is no need to use :guilabel:`Update`, :guilabel:`Insert` and :guilabel:`Delete` checkboxes in the WFS table in the :guilabel:`QGIS Server` tab. Lizmap does not use WFS-T. Lizmap will make the edit directly on the datasource. The configuration is done only in the panel described below.

.. note:: Be careful if your layer contains some Z or M values, unfortunately Lizmap will set them to "0" which is the default value when saving to the database.

Configuring the tool
--------------------

Here are the detailed steps:

* If necessary, **create a layer** in your database with the desired geometry type (point, line, polygon, etc.)

  - think about adding a **primary key**: this is essential!
  - the primary key column must be of type **auto-increment**. For example *serial* to PostgreSQL.
  - think about adding a **spatial index**: this is important for performance
  - *create as many fields as you need for attributes*: if possible, use simple field names!

Please refer to the QGIS documentation to see how to create a spatial layer in a PostGIS or Spatialite database: https://docs.qgis.org/3.4/en/docs/user_manual/managing_data_source/index.html

..  image:: /images/interface-add-edition-layer.jpg
   :align: center

- To enable a layer with edition capabilities:

    1. |add_layer|
    2. *Select the layer* in the drop-down list
    3. Check the actions you want to activate from:
        + Create
        + Modify attributes
        + Modify geometry
        + Delete

    4. Optional, you can add a list of groups which are allowed to edit, separated by a comma.

- |edit_layer|
- |remove_layer|
- |move_up_down_layer|
- |field_alias|

Reusing data of edition layers
------------------------------

The layers that you have selected for the editing tool are "layers like the others", which means:

* **QGIS styles and labels are applied to these layers.** You can create styles and labels that depend on a value of a layer column.

* If you want to propose the editing tool, but does not allow users to view data from the online layer (and therefore the additions of other users): **you can simply hide edition layers** by putting them in a *hidden* directory. See :ref:`hide-layers`

* **The layers are printable** if they are not masked.

* **The data are stored in a layer of the project**. The administrator can retrieve this data and use them thereafter.

.. note:: PostGIS or Spatialite? To centralize things, we recommend using a PostGIS database to store data. For Spatialite layers, be careful not to overwrite the Spatialite file stored in the Lizmap directory on the server with the one you have locally: remember always to make a backup of the server file before a new sync your local directory.

.. note:: Using the cache: whether to use the server or client cache for editing layers, do so by knowingly: the data will not be visible to users until the cache has not expired. We suggest not to enable the cache for editing layers.

Adding files and images for features
------------------------------------

Use the media/upload folder relative to the project
___________________________________________________

It is possible to upload your files, including images, for each feature, during online editing; to achieve this, you need to:

* Configure edition for the layer, with one or more fields with the **edit type** "Photo" or "File". For example, let say the field name is "photo"
* Create a folder at the root of the QGIS project file : **media/** and a subfolder **media/upload** (obviously you need to do that locally in your computer and server side ).
* Give webserver user (usually www-data) **write permission** on the upload folder, so that it can create files and folders in media/upload::

   chmod 775 -R media/upload && chown :www-data -R media/upload

* Check you ``php.ini`` to see if the variables ``post_max_size`` and ``upload_max_filesize`` are correctly set (by default, php only allows uploading files up to 2 Mbyte)

Lizmap will then create folders to store the data, depending on the layer name, field name, etc. For example, a file would be stored in the folder ``media/upload/PROJECT_NAME/LAYER_NAME/FIELD_NAME/FILE_NAME.EXT`` and an image in ``media/upload/environment/observations/species_picture/my_picture.png``.

Obviously you will be able to display this image (or any other file) in the popup, as it will be stored in the media folder. See :ref:`use-in-popups`

Use a specific destination folder
_________________________________

You can override the default destination folder ``media/upload/PROJECT_NAME/LAYER_NAME/FIELD_NAME/FILE_NAME.EXT`` by manually setting the path where to store the media, relatively to the project. To do so, you must use the **External resource** field edit widget, and configure it with:

* a **Default path** written relative to the project. For example ``../media/images/`` if you want to store this field files in a folder media situated alongside the project folder. You can also choose set a path inside the project media folder. For example ``media/my_target_folder/``.
* chek the **Relative path** checkbox, with the default **Relative to project path** option
* if the field should store a image, you should also check the **Integrated document viewer** checkbox, with the type **Image**

This allow to store the sent media files and images in a centralized folder, for example a directory **media** at the same level than the Lizmap repositories folders:

* media

  - images <-- to store images in this folder, use: ``../media/images/``
  - pdf

* environment

  - trees.qgs
  - trees.qgs.cfg
  - media

    * tree_pictures/ <-- to store images in this folder, use: ``media/tree_pictures/``
