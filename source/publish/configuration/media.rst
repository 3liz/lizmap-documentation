.. _media:

Media
=====

.. contents::
   :depth: 3

Principle
---------

It is possible to provide documents through Lizmap. To do this, you simply:

* Create a directory called :file:`media` (in lower case and without accents)

    * either **at the same level as the QGIS project**
    * or for some specific use-cases, one level up related to the QGIS project, to make it available for **all** folders
      (:ref:`single-media-folder`)

* Put documents in it : pictures, reports, PDFs, videos, HTML or text files
* Icons such as SVG for vector layers
* You can use subdirectories per layer or theme: the organization of :file:`media` directory content is free.

Lizmap is using the directory for other purposes:

* Adding some javascript, :file:`media/js`, see :ref:`adding-javascript`.
* Replacing the default theme, :file:`media/themes`, see :ref:`creating-simple-themes`.
* In the :ref:`editing` in :file:`media/upload/layer_name` for pictures uploaded from users.
* Providing documents

Then in Lizmap Web Client you can provide access to these documents for 2 things:

* the **popups**: the content of one or more field for each geometry can specify the path to the media. For example a *photo* or *pdf* field. See :ref:`popup`.
* the **link** provided for each group or layer in the Lizmap plugin :guilabel:`Layers` tab.

Details of these uses is specified below.

.. warning::
    Check your file permissions on the :file:`media` folder. If the folder is not readable, an error will occur.

Dot and dot-dot
---------------

On Linux, when you see dot ``.``, it means "this directory".

Two dots, ``..``, one after the other, means "the directory immediately above the current one".

The two dots notation is used in QGIS and Lizmap to go one level up in the tree related to the QGIS project,
see :ref:`single-media-folder`.

Use for links
-------------

It is possible to use a relative path to a document for layers or groups link.
Links can be filled with the Lizmap plugin :guilabel:`Layers` tab after selecting the layer or group. See :ref:`layers-tab-metadata`

..  image:: /images/publish-link.jpg
   :align: center

The path should be written:

* Starting with ``media/``
* Or with ``../media/`` if you want to use a single **media** folder, read :ref:`single-media-folder`
* With slashes ``/`` and not backslashes ``\``

Some examples:

* ``media/my_layer/metadata_layer.pdf``
* ``media/reports/my_report_on_the_layer.odt``
* ``media/a_picture.png``

On the Lizmap Web Client map, if a link has been set up this way for one of the layers, then an icon (i) will be placed to the right of the layer. Clicking this icon opens the linked document in a new browser tab.

.. warning::
    For editing capabilities, in :menuselection:`Layer properties --> Attributes Form`, for the given field,
    you should choose ``Attachment`` widget and set the path relative to the project.

    If the media is a picture, you should set the :guilabel:`Integrated Document Viewer` to ``Image``.

Use for SVG
-----------

In the QGIS, you can use custom SVG, in your layouts, symbology etc.

QGIS will display a absolute path but in the project, a relative path is saved. In the screenshot below, you can notice the
absolute path whereas if you open the QGS file in a text editor, it's a relative path :

``<prop v="../media/custom_svg/croissant.svg" k="name"/>``

..  image:: /images/media-custom-svg.jpg
   :align: center

The path is starting with ``../media``, it's using the media folder described below.

.. _single-media-folder:

Use a single media folder for many Lizmap folders
-------------------------------------------------

It's possible to use a single ``media`` folder located in the root data folder.
As the folder is located in the parent folder of the QGIS project, it's allowed to use ``../media`` in the QGIS project,
for instance in the attribute table of a layer to access a media file.

This will make files inside this media folder available for **all** folders, for instance for Javascript, images, PDF…

.. code-block:: bash

    ├── media
    │   └── js
    │   |    └── default
    │   |       ├── another_script.js
    │   |       └── one_script.js
    │   └── themes
    │   |    └── default
    │   |       └── css
    │   |          ├── main.css
    │   |          └── map.css 
    │   └── photo_1.jpg
    ├── my_repository
    │   ├── project_a.qgs
    │   ├── project_a.qgs.cfg
    │   ├── project_b.qgs
    │   └── project_b.qgs.cfg
    └── other_repo
        ├── media
        │   └── js
        │       ├── default
        │       │   └── script_for_all_projects_in_other_repo.js
        │       └── project_x
        │           └── script_for_project_x.js
        ├── project_x.qgs
        ├── project_x.qgs.cfg
        ├── project_y.qgs
        ├── project_y.qgs.cfg
        ├── project_z.qgs
        └── project_z.qgs.cfg


.. _use-in-popups:

Use in popups
-------------

Principle
_________

As described in the introduction above, you can use **a media path** in the spatial data layer.

For example, if you want that the popups associated with a layer displayed a picture that depends on each object, just create a new field that will contain the media path to the picture in each row of the layer attribute table, then activate popups for this layer.

Example
_______

Here for example the attribute table of a layer *landscape* configured to display pictures in the popup.
The user has created a ``picture`` field in which he places the path to the pictures and a ``pdf`` field in which he puts the paths to a pdf file describing the object corresponding to each line.

======  ======  ===========  ========================  ========================
id      name    description  picture                   pdf
======  ======  ===========  ========================  ========================
1       Marsh   blabla       media/photos/photo_1.png  media/docs/paysage-1.pdf
2       Beach   blibli       media/photos/photo_2.png  media/docs/paysage-2.pdf
3       Moor    bloblo       media/photos/photo_3.png  media/docs/paysage-3.pdf
======  ======  ===========  ========================  ========================

.. note:: In this example, we see that the pictures and PDF file names are normalized. Please follow this example because it allows using the QGIS Field Calculator to create or update automatically the media column data for the entire layer.

Result
______

Here are the display rules in the popup:

* If you are using a :guilabel:`auto` popup:

    - If the path points to a picture, the image will be displayed in the popup. Clicking on the picture will display the original image in a new tab.
    - If the path points to a text file or HTML file, the file contents will be displayed in the popup.
    - For any other file types, the popup will display a link to the document that users can download by clicking on the link.

* If you are using a :guilabel:`lizmap` popup, ``${name_of_the_field}`` will have the full URL to the media, starting by ``http``. This needs to be encapsulated to some HTML, such as ``<img />`` or ``<a href></a>``.

* Then if your are using a :guilabel:`qgis` popup:

    - ``[% "name_of_the_field" %]`` will return only the value of the field, like ``media/test.pdf``.
    - So for links, you need to use HTML, such as ``<a href="[% "name_of_field" %]">Link</a>``.
    - And for images, you need ``<img>`` (with an optional link to open it fullscreen) such as

.. code-block:: none

    <a href="[% "name_of_field" %]" target="_blank">
        <img src="[% "name_of_field" %]" border="0">
    </a>

Illustration
____________

Below is an illustration of a Lizmap popup displaying a picture, a text and a link in the popup:

.. image:: /images/features-popup-photo-example.jpg
   :align: center
   :width: 90%
