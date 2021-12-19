Custom templates
======================

In Lizmap each module (i.e., view, admin, action, etc.) defines some templates. Templates of each module are located in
:file:`lizmap/modules` folder. Each module has one or more templates (.tpl) in the templates folder
:file:`lizmap/modules/moduleX/templates/`. In order to customize the template of a module it is advisable to create a
copy of the files without modify the original files. To do this, it is necessary to create a copy of the templates
inside the default theme's folder of Lizmap, which is in :file:`var/themes/default`.

Prerequisites
-------------

* A folder with the same name of the module to which the template to redefine belongs, in the :file:`var/themes/default` folder.

Configuring the tool
--------------------

Simply copy the template to redefine in the module folder and customize it with a text editor.

Example
-------

We want to change the default title in the header of the main page of lizmap. The "view" module and the :file:`main.tpl`
template are involved in this procedure. We can see the name of the module in the URL bar (``myhost/lizmap/index.php/view/``).

* Create a directory named view in the theme's default folder

.. code-block:: bash

  nano mkdir lizmap/var/themes/default/view

* Copy the :file:`main.tpl` file from the default location in :file:`lizmap/modules/view/templates/` to the
  :file:`lizmap/var/themes/default/view` folder

.. code-block:: bash

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
