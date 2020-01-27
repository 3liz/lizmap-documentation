Atlas - a sequence of entities
==============================

Principle
---------

This feature let you chose and configure a layer to make a sequence of entities in your Lizmap project.

..  image:: /images/publish-04-atlas-plugin-interface.jpg
   :align: center
   :width: 80%

Configuring the tool
--------------------

Layer options :

* the atlas is enabled or not in your project
* you need to chose the layer you want your atlas on
* select the primary key field, it must be an integer
* check if you want to display the layer description in the dock of your atlas
* chose the field who contains the name of your features, it will be shown instead of the primary key in the list of features
* your atlas will be sorted according to this field
* you can chose to highlight the feature selected by the atlas, it will change every time it's switching to a new feature
* chose between a zoom on the feature or to make it the center of your map
* you can chose to display the popup in the feature in the atlas container or not
* check if you want to activate filter on the feature selected by the atlas, it will hide all other features of the layer and only show the one selected

Atlas options:

* check if you want to open the atlas tool when you open your project
* you can chose the size of the atlas dock (20%-50%)
* you can select the duration between each step when your atlas is in auto-play mode
* check if you want to launch the auto-play mode when you open your project
