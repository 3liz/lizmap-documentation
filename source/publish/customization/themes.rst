.. _creating-simple-themes:

Creating simple themes
======================

Starting from Lizmap Web Client version 2.10, it is possible to create themes for all maps of a repository or for a single map. This function needs to be activated by the administrator and uses the directory ``media``. Read how to use :ref:`media` in Lizmap.

The principle is:

* the directory ``media`` contains a directory named ``themes``
* the directory ``themes`` contains a default directory for the theme of all the maps of the repository
* the directory ``themes`` may contain a directory per project, for the themes specific for each project

.. code-block:: none

   -- media
     |-- themes
       |-- default
       |-- map_project_file_name1
       |-- map_project_file_name2
       |-- etc

In order to simplify the creation of a theme for a repository or a map, Lizmap allows you to obtain the default theme fro the application, through the request: ``index.php/view/media/getDefaultTheme``.

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

To preview your results just add ``&theme=yourtheme`` at the end of your URL (e.g. ``https://demo.lizmap.3liz.com/index.php/view/map/?repository=montpellier&project=montpellier&theme=yourtheme``).

Once your theme is ready, you can just publish it copying it in the directory ``media``.
