.. include:: ../../substitutions.rst

Atlas — A sequence of entities
==============================

.. contents::
   :depth: 3

Principle
---------

.. warning::
    This atlas feature is not linked to a QGIS layout based on an atlas. See :ref:`print-layout-atlas` for layouts using an atlas.

This feature let you chose and configure a layer to make a sequence of entities in your Lizmap project.

Many layers can be configured in this tool. If the checkbox :guilabel:`Auto-play` is checked, the first layer in the list is used.


Configuring the tool
--------------------

At the layer level
^^^^^^^^^^^^^^^^^^

..  image:: /images/interface-add-atlas.jpg
   :align: center

- For setting a atlas layer:

    1. .. include:: ../../shared/add_layer.rst
    2. you need to chose the layer you want your atlas on
    3. select the primary key field, it must be an integer
    4. check if you want to display the layer description in the dock of your atlas
    5. chose the field who contains the name of your features, it will be shown instead of the primary key in the list of features
    6. your atlas will be sorted according to this field
    7. you can chose to highlight the feature selected by the atlas, it will change every time it's switching to a new feature
    8. chose between a zoom on the feature or to make it the center of your map
    9. you can chose to display the popup in the feature in the atlas container or not
    10. check if you want to activate filter on the feature selected by the atlas, it will hide all other features of the layer and only show the one selected
    11. you can select the duration between each step

- .. include:: ../../shared/edit_layer.rst
- .. include:: ../../shared/remove_layer.rst
- .. include:: ../../shared/move_up_down_layer.rst

At the project level
^^^^^^^^^^^^^^^^^^^^

..  image:: /images/interface-atlas.jpg
   :align: center

Options:

    - check if you want to open the atlas tool when you open your project
    - check if you want to launch the auto-play mode when you open your project
