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

We want to change the logo and the navigation bar background color (e.g. blue) *only* in a specific project called ``roads`` and we want to keep the default theme
from the Lizmap *instance*:

* We don't need the :file:`media/themes/default` folder.
* Create :file:`media/themes/roads`.
* Extract the :file:`css/` directory from the zip file inside.
* Change the file :file:`css/img/logo.png`

This would work. But you still have a lot of CSS which is the same from the Lizmap main instance. So we can
make our style smaller:

* Remove all images which are the same as Lizmap instance
* Search in the :file:`css` folder where :file:`logo.png` is used.
* Remove every files :file:`*.css` except :file:`css/main.css` and :file:`css/map.css` and keep only:

.. code-block:: css

    #logo {
      background : url(img/logo.png) no-repeat;
      background-size:contain;
    }

for :file:`css/main.css` and:

.. code-block:: css

    #navbar button.btn {
      background-color : blue;
    }

for :file:`css/map.css`

By following these steps, we keep our custom theme as small as possible.

======================
Custom templates
======================

In Lizmap each module (i.e., view, admin, action, etc.) defines some template. Templates of each module are located in :file:`lizmap/modules` folder. Each module has one or more templates (.tpl) in the templates folder :file:`lizmap/modules/moduleX/templates/`. In order to customize the template of a module it is advisable to create a copy of the files without modify the original files. To do this, it is necessary to create a copy of the templates inside the default theme's folder of Lizmap, which is in :file:`var/themes/default`.

Prerequisites
-------------

* A folder with the same name of the module to which the template to redifine belongs, in the :file:`var/themes/default` folder.

Configuring the tool
--------------------
Simply copy the template to redifine in the module folder and custmize it with a text editor.

Example
-------
We want to change the default title in the header of the main page of lizmap. The "view" module and the :file:`main.tpl` template are involved in this procedure. We can see the name of the module in the URL bar (``myhost/lizmap/index.php/view/``).

* Create a directory named view in the theme's default folder

.. code-block:: none
nano mkdir lizmap/var/themes/default/view

* Copy the :file:`main.tpl` file from the default location in :file:`lizmap/modules/view/templates/` to the :file:`lizmap/var/themes/default/view` folder

.. code-block:: none
cp lizmap/var/themes/default/view/main.tpl lizmap/var/themes/default/view

* Find the title div and replace the original code with your custom text 


.. code-block:: html

  <div id="title">
    <h1>{$repositoryLabel}</h1>
  </div>


.. code-block:: html

  <div id="title">
    <h1>Some Text</h1>
  </div>

Done!
