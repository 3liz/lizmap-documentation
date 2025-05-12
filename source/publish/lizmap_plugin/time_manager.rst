.. include:: ../../substitutions.rst

Time Manager — Animation of temporal vector layers
==================================================

.. contents::
   :depth: 3

Principle
---------

You can create animations of your vectors, provided you have at least a layer with a column with a valid date/time.

Example
-------

* On the `demo website <https://demo.lizmap.com/lizmap/index.php/view/map?repository=features&project=time_manager_earthquake>`_,
  look at the **Earthquake** in Indonesia. You can download the QGIS project to see how it's done.
* A `video tutorial <https://vimeo.com/83845949>`_ is available. It shows all the steps to use the functionality.


Prerequisites
-------------

.. include:: ../../shared/wfs_layer.rst

Configuring the tool
--------------------

After the configuration, your web application will display the symbol of a watch; clicking on it will open a small panel
that will allow you to move between steps, or play the entire animation. At startup, the application will load the entire
table, so if you have thousands of objects you may need to wait for several seconds before the application is available.

.. note::
    Several different formats for date/time are acceptable (those supported by the JavaScript library `Moment`).
    You can check whether your format is supported by reading the documentation on `Moment <https://momentjs.com/>`_.

At the layer level
^^^^^^^^^^^^^^^^^^

.. image:: /images/publish-time-manager.jpg
    :align: center
    :scale: 80%

- For setting the time manager with one layer:

    1. .. include:: ../../shared/add_layer.rst
    2. One layer with date/time capabilities.
    3. The start column with date/time. It can any kind of fields.
    4. The end column with date/time. This is optional.
    5. Date/time resolution of the chosen attribute(s).
    6. For not database based layer, you must compute the minimum and maximum values.

.. warning::
    Date/time resolution can have a different value than *Frame type*. You might select ``years`` for *Frame type* 
    but your date field could have a ``Days`` resolution.

- .. include:: ../../shared/edit_layer.rst
- .. include:: ../../shared/remove_layer.rst
- .. include:: ../../shared/move_up_down_layer.rst

At the project level
^^^^^^^^^^^^^^^^^^^^

..  image:: /images/interface-time-manager.jpg
   :align: center

Options:

    - Time frame size
    - Frame type
    - Animation frame length
