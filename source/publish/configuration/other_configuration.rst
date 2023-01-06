Other configuration
===================

.. contents::
   :depth: 3

Changing the default image of a project
---------------------------------------

By default the following image is displayed for a project:

.. image:: /images/mapmonde.jpg
   :align: left
   :width: 15%


You can change this default image by adding in the same project folder a ``.png``, ``.jpg``, ``.jpeg``, ``.gif``, ``.webp`` or ``.avif`` image with the exact project
name and extension. Example, if the project is called :file:`montpellier.qgs` you must add an image named
:file:`montpellier.qgs.png`. Note that the image has the project extension too.

.. note::
      To save bandwidth and speed up the projects page load you should:

      * Create images with a width of **250 pixels maximum**.
      * Use ``.webp`` as it produces images that are much smaller than other formats and is very well supported `by modern browsers <https://caniuse.com/webp>`_. For even smaller images you can use ``.avif`` but you should take care of `browser compatibility <https://caniuse.com/avif>`_.
      * Use `Squoosh <https://squoosh.app/>`_ or any other tool to convert from one image format to another and reduce quality as much as it is possible whithout being visually perceptible.

.. warning:: It might be needed to clear the cache and force reload the page from the web browser.
