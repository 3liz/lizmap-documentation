.. include:: ../../substitutions.rst

Atlas - a sequence of entities
==============================

Principle
---------

This feature let you chose and configure a layer to make a sequence of entities in your Lizmap project.

Since |lizmap_3_4| :

Many layers can be configured in this tool. If the checkbox :guilabel:`Auto-play` is checked, the first layer in the list is used.


Configuring the tool
--------------------

..  image:: /images/interface-add-atlas.jpg
   :align: center

- For setting a atlas layer:

    1. |add_layer|
    2. you need to chose the layer you want your atlas on
    3. select the primary key field, it must be an integer
    4. check if you want to display the layer description in the dock of your atlas
    5. chose the field who contains the name of your features, it will be shown instead of the primary key in the list of features
    6. your atlas will be sorted according to this field
    7. you can chose to highlight the feature selected by the atlas, it will change every time it's switching to a new feature
    8. chose between a zoom on the feature or to make it the center of your map
    9. you can chose to display the popup in the feature in the atlas container or not
    10. check if you want to activate filter on the feature selected by the atlas, it will hide all other features of the layer and only show the one selected

- |edit_layer|
- |remove_layer|

The order in the table is important.

- |move_up_down_layer|

- Atlas options:

    - check if you want to open the atlas tool when you open your project
    - you can select the duration between each step when your atlas is in auto-play mode for the first layer of the table
    - check if you want to launch the auto-play mode when you open your project
