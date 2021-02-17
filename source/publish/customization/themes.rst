.. _creating-simple-themes:

Creating simple themes
======================

.. contents::
   :depth: 3

Principle
---------

It is possible to create themes for all maps of a repository or for a single map within a repository.

The principle is:

* the directory :file:`media` contains a directory named :file:`themes`
* the directory :file:`themes` contains a :file:`default` directory for the theme of all the maps of the repository
* the directory :file:`themes` may contain too one directory per project, for the themes specific for each project

.. code-block:: none

   -- media
     |-- themes
       |-- default
       |-- map_project_file_name1
       |-- map_project_file_name2
       |-- etc

Prerequisites
-------------

* This function needs to be activated by the administrator of the Lizmap instance.
* The :file:`media` directory. Read how to use :ref:`media` folder in Lizmap.

Configuring the tool
--------------------

.. warning:: The web browser has some caching mechanism. Do not forget to refresh and force the cache with
    Ctrl+F5.

In order to simplify the creation of a theme for a repository or a map, Lizmap allows you to obtain the
default theme from the application, through the request: ``index.php/view/media/getDefaultTheme``.

The request returns a zipfile containing the default theme, with the following structure:

.. code-block:: none

   -- lizmapWebClient_default_theme.zip
     |-- default
       |-- css
         |-- main.css
         |-- map.css
         |-- media.css
         |-- img
           |-- loading.gif
           |-- etc
         |-- images
           |-- sprite_20.png
           |-- etc

Once downloaded the zipfile, you can:

* replace the images
* edit the CSS files

.. warning:: The files and directories must be readable (755:644)


.. tip::
    To preview your results without deploying it in production, you can add your theme in the
    :file:`lizmap/www/themes`.
    Add ``&theme=yourtheme`` at the end of your URL (e.g.
    ``https://your.lizmap.instance/index.php/view/map/?repository=montpellier&project=montpellier&theme=yourtheme``).

Once your theme is ready, you can just publish it copying it in the directory ``media``.

Example
-------

We want to change *only* the logo in a specific project called ``roads`` and we want to keep the default theme
from the Lizmap *instance*:

* We don't need the :file:`media/themes/default` folder.
* Create :file:`media/themes/roads`.
* Extract the content zip file inside.
* Change the file :file:`css/img/logo.png`

This would work. But you still have a lot of CSS which is the same from the Lizmap main instance. So we can
make our style smaller:

* Remove all images which are the same as Lizmap instance
* Search in the :file:`css` folder where :file:`logo.png` is used.
* Remove every files :file:`*.css` except the file :file:`css/main.css` and keep only:

.. code-block:: css

    #logo {
      background : url(img/logo.png) no-repeat;
      background-size:contain;
    }

By following these steps, we keep our custom theme as small as possible.
