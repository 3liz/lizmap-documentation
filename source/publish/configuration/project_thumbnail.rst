.. _thumbnail:

Project thumbnail
=================

By default the following image is displayed for a project:

.. image:: /images/mapmonde.jpg
   :align: left
   :width: 15%
   :alt: The default project thumbnail in Lizmap Web Client


You can change this default image by adding, **next to** your :file:`QGS file`, a image with the exact project name and
extension included.

Extensions can be ``.webp``, ``.png``, ``.jpg``, ``.jpeg``, ``.gif``  or ``.avif``. We recommend the **first** format.

Example, if the project is called :file:`montpellier.qgs` you must add, next to it, an image named
:file:`montpellier.qgs.png`. Note that the image has the project extension ``.qgs`` too in its filename.

.. note::
      To save bandwidth and speed up the projects page load you must:

      * Create images with a width of **250 pixels maximum**.
      * Use ``.webp`` as it produces images that are much smaller than other formats and is very well supported
        `by modern browsers <https://caniuse.com/webp>`_. For even smaller images you can use ``.avif`` but you should
        take care of `browser compatibility <https://caniuse.com/avif>`_.
      * Use `Squoosh <https://squoosh.app/>`_ or any other tool to convert from one image format to another and reduce
        quality as much as it is possible without being visually perceptible.

.. warning::
    To see the thumbnail **immediately**, it might be needed to clear the cache in your web browser and force reload
    the page from the web browser.

    Otherwise, the thumbnail will be displayed **automatically in a few hours**, when the web browser will understand
    that the image has changed. Web browsers tries to save some network requests.
