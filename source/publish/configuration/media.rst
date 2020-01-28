.. _media:

Media
=====

Principle
---------

It is possible to provide documents through Lizmap. To do this, you simply:

* create a directory called **media** (in lower case and without accents) *at the same level as the QGIS project*
* **place documents in it**: pictures, reports, pdfs, videos, HTML or text files
* the documents contained in this **media** directory must be **synchronized as other data**
* you can use subdirectories per layer or theme: the organization of **media** directory content is free.

Then in Lizmap Web Client you can provide access to these documents for 2 things:

* the **popups**: the content of one or more field for each geometry can specify the path to the media. For example a *photo* or *pdf* field
* the **link** provided for each group or layer in the Lizmap plugin *Layers* tab.

Details of these uses is specified below.

Use for links
-------------

It is possible to use a relative path to a document for layers or groups link.

.. note:: Links can be filled with the Lizmap plugin **Layers** tab after selecting the layer or group. See :ref:`layers-tab-metadata`

The path should be written:

* starting with **media/**
* with slashes **/** and not backslashes

Some examples:

* *media/my_layer/metadata_layer.pdf*
* *media/reports/my_report_on_the_layer.doc*
* *media/a_picture.png*

On the Lizmap Web Client map, if a link has been set up this way for one of the layers, then an icon (i) will be placed to the right of the layer. Clicking this icon opens the linked document in a new browser tab.

.. _use-in-popups:

Use in popups
-------------

Principle
_________

As described in the introduction above, you can use **a media path** in the spatial data layer.

For example, if you want that the popups associated with a layer displayed a picture that depends on each object, just create a new field that will contain the media path to the picture in each row of the layer attribute table, then activate popups for this layer.

Example
_______

Here for example the attribute table of a layer *landscape* configured to display pictures in the popup. The user has created a *picture* field in which he places the path to the pictures, and a *pdf* field in which he puts the paths to a pdf file describing the object corresponding to each line.

======  ======  ===========  ========================  ========================
id      name    description  picture                   pdf
======  ======  ===========  ========================  ========================
1       Marsh   blabla       media/photos/photo_1.png  media/docs/paysage-1.pdf
2       Beach   blibli       media/photos/photo_2.png  media/docs/paysage-2.pdf
3       Moor    bloblo       media/photos/photo_3.png  media/docs/paysage-3.pdf
======  ======  ===========  ========================  ========================

.. note:: In this example, we see that the pictures and pdf file names are normalized. Please follow this example because it allows using the QGIS Field Calculator to create or update  automatically the media column data for the entire layer.

Result
______

Here are the display rules in the popup:

* if the path points **to a picture, the image will be displayed** in the popup. Clicking on the picture will display the original image in a new tab
* if the path points **to a text file or HTML file, the file contents will be displayed** in the popup
* for **other file types, the popup will display a link to the document** that users can download by clicking on the link.

Illustration
____________

Below is an illustration of a Lizmap popup displaying a picture, a text and a link in the popup:

.. image:: /images/features-popup-photo-example.jpg
   :align: center
   :width: 90%
