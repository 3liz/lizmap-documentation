Editing spatial data
====================

The map publisher can allow users to edit certain data. It also has the ability to limit possible changes:

* adding spatial object
* geometric modification
* fields modification
* deleting spatial object

The feature is available in the Lizmap menu bar. The edit menu allows you to select the data you want to update.

.. image:: /images/user-guide-19-edition-menu.jpg
   :align: center
   :scale: 80%

Once the layer selected, the edit pannel appears. This varies depending on the configuration desired by the map publisher. If any changes are available you have to choose between *Add* a new object or *Select* one.

.. image:: /images/user-guide-20-edition-add.jpg
   :align: center
   :scale: 80%

If you have selected *Add*, you will be asked to draw a simple form that depends on the selected data layer:

* point
* line
* polygon

In the case of line and polygon, you need to click several times to draw the shape you want.

.. image:: /images/user-guide-21-edition-add-draw.jpg
   :align: center
   :scale: 80%

To finish your line or your polygon you must add the last point by double-clicking the desired location. Once drawing finished, an editing form for fields will be displayed.

.. image:: /images/user-guide-22-edition-add-attributes.jpg
   :align: center
   :scale: 80%

If you want to restart drawing the geometry, you should click *Cancel*.

If the geometry is right for you and you have entered the required information, you can *Save*. The new object will be added. You will be able to update it by selecting it.

To select an object to update, you will need to click on it on the map then click on the button *Edit*.

.. image:: /images/user-guide-23-edition-select.jpg
   :align: center
   :scale: 80%

#. The selected object appears on the map and its geometry may be changed immediatly.
#. You can undo geometry changes and stop edition using the *Cancel* button.
#. To validate your geometry modifications, you must click *Save*.

.. image:: /images/user-guide-26-edition-select-draw-undo-validate.jpg
   :align: center
   :scale: 80%

If you want to remove a point on a geometry, you must hover it and type *Del* on your keyboard.

*Digitizing* button is displayed with line and polygon geometries, by clicking it, you'll access those tools:

#. Node tool (default). Move or delete the geom nodes (vertices) and also create new ones by dragging virtual nodes in the middle of the segments.
#. Drag tool. Translate a geometry by dragging the displayed point at the center of the geometry.
#. Rotate tool. Rotate a geometry by dragging the displayed point at bottom right of the geometry.
#. Reshape tool.
#. Split tool.
#. Reverse geom (To be used with the node tool). Reverse nodes (vertices) order. Useful for streets when their circulation orientation is reversed for example.

.. image:: /images/user-guide-27-edition-digitizing.jpg
   :align: center
   :scale: 80%
