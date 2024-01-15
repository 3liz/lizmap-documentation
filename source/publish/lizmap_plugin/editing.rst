.. include:: ../../substitutions.rst

.. _editing:

Editing — Edit a layer from the web interface
=============================================

.. contents::
   :depth: 3

Principle
---------

It is possible to allow users to **edit spatial and attribute data** from the Lizmap Web Client interface for **PostgreSQL** layers.
The Lizmap plugin allows you to add one or more layers and choose what actions for each will be possible in the web interface:

* creating elements
* modifying attributes
* modifying the geometry
* deleting elements

The **Web form** presented to the user to populate the **attribute table** supports **editing tools** available in the
*fields* tab of the QGIS Vector *layer properties*. You can configure a dropdown, hide a column, make it non-editable,
use a check box, a text area, etc. All configuration is done with the mouse, in QGIS and the Lizmap plugin.

In addition, Lizmap Web Client automatically detects the column type (integer, real, string, etc.) and adds the necessary
checks and controls on the fields.

Examples
--------

* **A town** wish that citizens identify visible problems on the road: uncollected trash, broken street lights, wrecks
  to remove. The QGIS project administrator creates a layer dedicated to collect data and displays them to all.

* **An engineering office** wants to allow project partners to trace remarks on the project areas. It allows the addition
  of polygons in a dedicated layer.

.. _editing-prerequisites:

Prerequisites
-------------

To allow data editing in Lizmap Web Client, you must:

* Have vector layer stored in PostgreSQL.
* The vector layer mustn't have space in field names.
* Configure the editing tool for the layer in :menuselection:`Layer Properties --> Attributs Form`. This is not required
  but recommended to control the data entered by users. See :ref:`form` for more information about layout, widgets,
  expressions, constraints in a form.
* .. include:: ../../shared/wfs_layer.rst
* Despite we want to edit the layer, there is no need to use :guilabel:`Update`, :guilabel:`Insert` and :guilabel:`Delete`
  checkboxes in the WFS table in the :guilabel:`QGIS Server` tab. Lizmap does not use WFS-T. Lizmap will make the edit
  directly on the datasource. The configuration is done only in the panel described below.
* As a consequence as above :

  * The credentials **must not** use the **Authentification system provided by QGIS** for a layer with edition capabilities.
    Credentials must be either in the **QGS** project file or in the PostgreSQL service file (recommended, more secure
    because credentials are not stored in the QGIS project) :

    * `How to use service file on docs.qgis.org <https://docs.qgis.org/latest/en/docs/user_manual/managing_data_source/opening_data.html#postgresql-service-connection-file>`_
    * `How to use service file on postgresql.org <https://www.postgresql.org/docs/current/libpq-pgservice.html>`_

.. note::
    Be careful if your layer contains some Z or M values, unfortunately Lizmap will set them to "0" which is the default
    value when saving to the database.

Configuring the tool
--------------------

Here are the detailed steps:

* If necessary, **create a layer** in your database with the desired geometry type (point, line, polygon, etc.)

  - think about adding a **primary key**: this is essential!
  - the primary key column must be of type **auto-increment**. For example *serial* to PostgreSQL.
  - think about adding a **spatial index**: this is important for performance
  - *create as many fields as you need for attributes*: if possible, use simple field names!

Please refer to the `QGIS documentation <https://docs.qgis.org/latest/en/docs/user_manual/managing_data_source/index.html>`_
to see how to create a spatial layer in a PostgreSQL database.

..  image:: /images/interface-add-edition-layer.jpg
   :align: center

- To enable a layer with edition capabilities:

    1. .. include:: ../../shared/add_layer.rst
    2. *Select the layer* in the drop-down list
    3. Check the actions you want to activate from:
        + :guilabel:`Create`
        + :guilabel:`Edit attributes`
        + :guilabel:`Edit geometry`
        + :guilabel:`Delete`
    4. Optional, you can add a list of groups which are allowed to edit, separated by a comma.
    5. Snapping can be activated if you select at least one layer in the layer list.
        + .. include:: ../../shared/wfs_layer.rst
    6. If one layer is selected above, at least one checkbox must be used :
        + :guilabel:`Vertices`
        + :guilabel:`Segments`
        + :guilabel:`Intersections`
    7. It's possible to set the tolerance for the snapping.

- .. include:: ../../shared/edit_layer.rst
- .. include:: ../../shared/remove_layer.rst
- .. include:: ../../shared/move_up_down_layer.rst
- .. include:: ../../shared/field_alias.rst

Configuring the form
--------------------

The form in Lizmap is inherited from the :guilabel:`Layer Properties`. Read the :ref:`form`.

Reusing data of edition layers
------------------------------

The layers that you have selected for the editing tool are "layers like the others", which means:

* **QGIS styles and labels are applied to these layers.** You can create styles and labels that depend on a value of a
  layer column.

* If you want to propose the editing tool, but does not allow users to view data from the online layer (and therefore
  the additions of other users): **you can simply hide edition layers** by putting them in a *hidden* directory.
  See :ref:`hide-layers`

* **The layers are printable** if they are not masked.

* **The data are stored in a layer of the project**. The administrator can retrieve this data and use them thereafter.

.. note::
    Using the cache: whether to use the server or client cache for editing layers, do so by knowingly: the data
    will not be visible to users until the cache has not expired. We suggest not to enable the cache for editing layers.

Adding files and images for features
------------------------------------

Use the media/upload folder relative to the project
___________________________________________________

It is possible to upload your files, including images, for each feature, during online editing; to achieve this, you
need to:

* Configure edition for the layer, with one or more fields with the :guilabel:`edit type` ``Photo`` or ``File``.
  For example, let say the field name is ``photo``.
* Create a folder at the root of the QGIS project file : :file:`media/` and a subfolder :file:`media/upload`
  (obviously you need to do that locally in your computer and server side).
* Give to the webserver user (usually www-data) **write permission** on the upload folder, so that it can create files
  and folders in :file:`media/upload`:

   chmod 775 -R media/upload && chown :www-data -R media/upload

* Check you :file:`php.ini` to see if the variables ``post_max_size`` and ``upload_max_filesize`` are correctly set
  (by default, PHP only allows uploading files up to 2 Mbyte)

Lizmap will then create folders to store the data, depending on the layer name, field name, etc. For example, a file
would be stored in the folder :file:`media/upload/PROJECT_NAME/LAYER_NAME/FIELD_NAME/FILE_NAME.EXT` and an image in
:file:`media/upload/environment/observations/species_picture/my_picture.png`.

Obviously you will be able to display this image (or any other file) in the popup, as it will be stored in the media folder.
See :ref:`use-in-popups`

Use a specific destination folder
_________________________________

You can override the default destination folder :file:`media/upload/PROJECT_NAME/LAYER_NAME/FIELD_NAME/FILE_NAME.EXT` by
manually setting the path where to store the media, relatively to the project. To do so, you must use the
:guilabel:`External resource` field edit widget, and configure it with:

* a :guilabel:`Default path` written relative to the project. For example :file:`../media/images/` if you want to store
  this field files in a folder media situated alongside the project folder. You can also choose set a path inside the
  project media folder. For example :file:`media/my_target_folder/`.
* check the :guilabel:`Relative path` checkbox, with the default :guilabel:`Relative to project path` option
* if the field should store a image, you should also check the :guilabel:`Integrated document viewer` checkbox, with
  the type :guilabel:`Image`

This allow to store the sent media files and images in a centralized folder, for example a directory :file:`media` at
the same level than the Lizmap repositories folders:

* media

  - images <-- to store images in this folder, use :file:`../media/images/`
  - pdf

* environment

  - trees.qgs
  - trees.qgs.cfg
  - media

    * tree_pictures/ <-- to store images in this folder, use: :file:`media/tree_pictures/`

Use a WebDAV remote storage
_________________________________

It is possible to store your files in a remote server that supports the `WebDAV protocol` 
(e.g. `Nextcloud <https://nextcloud.com>`_). To achieve this you must:

- Configure the :guilabel:`Attachments` edit widget for the chosen field as follow:

  1. In the :guilabel:`Storage type` field, select the :guilabel:`WebDAV Storage` option
  2. In the :guilabel:`External Storage`` section, on the :guilabel:`Store URL` field, add an **expression** which
     indicates the full URL of the remote path for the file. The expression string must:

    * start with the remote storage URL of the **root** folder of the WebDAV server
    * include or not any destination subfolder 
    * end with the :code:`file_name(@selected_file_path)` expression

  3. update the :guilabel:`Authentication` section with your :code:`user name` and :code:`password` (optional, read 
     below about authentication)

  ..  image:: /images/webdav-configure-attachment-widget.jpg
    :align: center

  For example, if you want to upload a file in your WebDAV server :code:`https://webdav/dav` in the subfolder
  :code:`pictures/2024/` then the full expression will be:
  
  :code:`'https://webdav/dav/pictures/2024/'||file_name(@selected_file_path)`

  You can also upload a file directly in the root folder, simply change the expression above in 
  :code:`'https://webdav/dav/'||file_name(@selected_file_path)`

  .. tip:: 
    You can configure different fields on the same layer or in different layers to upload files to your remote storage 
    under different subfolders.

- Configure your Lizmap installation to recognize your WebDAV storage. To do so in your 
  :file:`var/config/profiles.ini.php` edit the :code:`[webdav:default]` section:

  .. code-block:: ini

    [webdav:default]
    baseUri=https://webdav/dav/
    enabled=1
    user=mywebdavuser
    password=mywebdavpassword

  where:

    * :code:`baseUri`  is the root folder of your WebDAV server. It must end with ``/`` and it must be the same as
      indicated in the :guilabel:`Attachment widget`
    * :code:`enabled`  set it to ``1`` switch on the WebDAV configuration, or to ``0`` to switch it off
    * :code:`user`     WebDAV baseUri authentication user, same as same as configured in the Authentication section
      of External storage configuration (Attachment widget)
    * :code:`password` WebDAV baseUri authentication password, same as configured in the Authentication section of
      External storage configuration (Attachment widget)

  .. note::
    :code:`user` and :code:`password` fields are not mandatory, depends on how you intend to manage the WebDAV
    storage.

  .. note::
    Configure multiple WebDAV servers on the same Lizmap installation is not supported, so you can configure
    only one WebDAV endpoint per installation.

  .. warning::
    To get files from remote storage the :code:`baseUri` will be **exposed** on the web client.

  .. warning::
    If an user upload two files with the same name the first file could be overwritten. This behaviour cannot
    be controlled by Lizmap since it concerns the configuration and the structure of the WebDAV server.

  .. tip::
    To prevent files from being overwritten you can set the :guilabel:`Store URL` by placing a :code:`uuid` in
    front of the file name,
    for example: ``'https://webdav/dav/pictures/2024/'||uuid('WithoutBraces')||'_'||file_name(@selected_file_path)``
    

After you had done the two configuration steps above you are able to:

  - **upload** a new file from the layer edition form
  - **delete** an existing file from the layer edition form
  - **access** the file via Attribute table (see :ref:`attribute_table`)
  - **access** the file or get a **preview** of the file content via Popup (see :ref:`use-in-popups`)
