The projects pages
==================

The default lizmap page offers a list maps organized by folder.

.. image:: /images/user-guide-01-projects.png
   :align: center
   :scale: 80%

You can access to the map information sheet. This informations come directly from QGIS project.

.. image:: /images/user-guide-02-information.png
   :align: center
   :scale: 80%

Access to the map is done either by clicking the **Load the map** buttons or the image that accompanies the project.

A simple map
============

Lizmap offers default web maps with the following features:

* pan
* zoom on area drawn by the user
* zoom more
* selecting a zoom level with a scale bar
* zoom less
* scale display as a scale bar and numerically

The order and organization of layers in the layers panel management meet those defined in the QGIS by the map publisher.

.. image:: /images//user-guide-03-simple-map.png
   :align: center
   :scale: 80%

Zooming and paning are available on the right of the map. To zoom on an area, you need to select the *zoom by rectangle* and drag to draw a rectangle defining the area to reach.

.. image:: /images//user-guide-03-simple-map-zoom.png
   :align: center
   :scale: 80%

You can using the *triangle*, left the layers title, bring up the legend of the layer.

.. image:: /images//user-guide-04-legend.png
   :align: center
   :scale: 80%

Selection boxes allow you to hide and display the proposed layers.

.. image:: /images//user-guide-05-show-hide-layer.png
   :align: center
   :scale: 80%

To take full advantage of the map, you can hide the panel management layers.

.. image:: /images//user-guide-06-hide-layer-switcher.png
   :align: center
   :scale: 80%

Finally you can:

* go back to the projects page
* display the map information sheet

Authentication
==============

The admin can restrict access to certain map groups. To access these maps, you must authenticate. Authentication is accessible through the button *Connect* at the top left.

.. image:: /images//user-guide-07-authentication.png
   :align: center
   :scale: 80%

Once authentication is enabled, depending on your rights, you should have access to new maps.

.. image:: /images//user-guide-07-authentication-projects.png
   :align: center
   :scale: 80%

You can log out and edit your user information.

Advanced features
=================

The map publisher can add some features depending on the desired user experience:

* selecting a basemap
* locate by layer
* distance, area and perimeter measurements
* printing the map
* editing data
* statictics 


.. image:: /images//user-guide-07-advanced-features.png
   :align: center
   :scale: 80%

Selecting a basemap
-------------------

Using the Lizmap plugin, the editor may have added external base maps or an empty base layer to the map. These base maps are available in the layer management panel as a list.

.. image:: /images//user-guide-08-baselayers.png
   :align: center
   :scale: 80%

Locate by layer
---------------

This feature is displayed by default if it has been activated by the map publisher.

It is located above the layer management panel and is in the form of lists. Some lists need to enter a few characters before proposing locations.

.. image:: /images//user-guide-09-locate-by-layer.png
   :align: center
   :scale: 80%


Simply select a location from the list to zoom to the item.

.. image:: /images//user-guide-09-locate-by-layer-zoom.png
   :align: center
   :scale: 80%

Measurement
-----------

Measurement feature give you the ability to calculate:

* a distance
* an area
* a perimeter

It is available in the Lizmap menu bar.

.. image:: /images//user-guide-10-measure-menu.png
   :align: center
   :scale: 80%

The tool is activated by selecting the measurement type. Once activated, a message tells you what to do.

.. image:: /images//user-guide-11-measure-activated.png
   :align: center
   :scale: 80%

The measurement is displayed in the status bar.

.. image:: /images//user-guide-12-measure-value.png
   :align: center
   :scale: 80%

By double-clicking on the map, the measurement is fixed. To start over, you can click on the map and restart the measurement calculation.

In the feature bar, the button on the right allows to stop using it.

.. image:: /images//user-guide-13-measure-stop.png
   :align: center
   :scale: 80%

It is also possible to change the measurement functionality without having to stop the feature.


Printing
--------

The print feature is available in the Lizmap menu bar. It depends on the number of print compositions published by the map publisher.

.. image:: /images//user-guide-14-print-menu.png
   :align: center
   :scale: 80%

Once the feature activated, a print area with the form of the composition is displayed on the map. Use this area to define the area to be printed. You can move it.

.. image:: /images//user-guide-15-print-zone.png
   :align: center
   :scale: 80%

On the left, above the panel layer management, you can select the scale of printing.

.. image:: /images//user-guide-16-print-scale.png
   :align: center
   :scale: 80%

Depending on the configuration of the printing composition, you can have the possibility to enter your own text.

.. image:: /images//user-guide-17-print-input.png
   :align: center
   :scale: 80%

To begin building the print file, you can click on *Print*. You will get a PDF file with the layout defined by the map publisher.

.. image:: /images//user-guide-18-print-result.png
   :align: center
   :scale: 80%


Editing spatial data
--------------------

The map publisher can allow users to edit certain data. It also has the ability to limit possible changes:

* adding spatial object
* geometric modification
* fields modification
* deleting spatial object

The feature is available in the Lizmap menu bar. The edit menu allows you to select the data you want to update.

.. image:: /images//user-guide-19-edition-menu.png
   :align: center
   :scale: 80%

Once the layer selected, the edit pannel appears. This varies depending on the configuration desired by the map publisher. If any changes are available you have to choose between *Add* a new object or *Select* one.

.. image:: /images//user-guide-20-edition-add.png
   :align: center
   :scale: 80%

If you have selected *Add*, you will be asked to draw a simple form that depends on the selected data layer:

* point
* line
* polygon

In the case of line and polygon, you need to click several times to draw the shape you want.

.. image:: /images//user-guide-21-edition-add-draw.png
   :align: center
   :scale: 80%

To finish your line or your polygon you must add the last point by double-clicking the desired location. Once drawing finished, an editing form for fields will be displayed.

.. image:: /images//user-guide-22-edition-add-attributes.png
   :align: center
   :scale: 80%

If you want to restart drawing the geometry, you should click *Cancel*.

If the geometry is right for you and you have entered the required information, you can *Save*. The new object will be added. You will be able to update it by selecting it.

To select an object to update, you will need to click on it on the map then click on the button *Edit*.

.. image:: /images//user-guide-23-edition-select.png
   :align: center
   :scale: 80%

The selected object appears on the map and its geometry may be changed immediatly.

.. image:: /images//user-guide-26-edition-select-draw.png
   :align: center
   :scale: 80%

You can undo geometry changes using the *Cancel* button.

.. image:: /images//user-guide-27-edition-select-draw-undo.png
   :align: center
   :scale: 80%

To validate your geometry modifications or simply access the editing form for fields, you must click *Save*.

.. image:: /images//user-guide-28-edition-select-draw-validate.png
   :align: center
   :scale: 80%

A dialog box containing the editing form for fields of the object appears.

.. image:: /images//user-guide-29-edition-select-draw-form.png
   :align: center
   :scale: 80%

The *Save* button saves the geometry and attributes changes.

If you want to remove the object you selected, you must click *Del*.

Finally, to disable editing tool, simply click on *Close* or click again on the Edition icon.

.. image:: /images//user-guide-30-edition-stop.png
   :align: center
   :scale: 80%



Attribute layers
================

When this feature has been enabled by the map publisher for one or many vector layers, a new menu entry will be visible at the bottom of the menu bar, labelled as **Data**.

Clicking on this icon will open a new panel situated at the bottom of the interface, containing one single **Data** tab with a list of published vector layers.

.. image:: /images//user-guide-31-attribute-menu.png
   :align: center
   :scale: 80%

Attribute table panel behaviour
-------------------------------

Since this panel is situated above the map, some default behaviours have been proposed to ease the consultation of the data in the map and in the table at the same time.

* The attribute table panel takes half the size of the screen
* It is automatically reduced at the bottom when the mouse is out of it, and automatically displayed back when the user moves the mouse over the bottom of the map.

You can change the default behaviour by using the buttons displayed at the bottom of the attribute table panel

* The **Pin** button deactivates the automatic reduction of the panel when the user mouse leaves it. But in this case, the whole panel will be displayed half transparent to allow the user to see the map underneath.
* The **Maximise** button expands the panel so that it occupies the total place left between the left panel and the map header. This is handy when you need to have a confortable view of the layer data. In this configuration, the attribute table panel is also **pinned**, and won't be reduced when the mouse leaves the panel, for example when hovering the left panel with the legend. But in this case, only the opacity of the attribute table panel will change so that you can see the map underneath.

You can click back on any of these 2 **Pin** and **Maximise** button to get back to the default behaviour.

The **Close** button closes the attribute table tool completely (as if you clicked in the menu bar icon).

.. image:: /images//user-guide-32-attribute-menu-tools.png
   :align: center
   :scale: 80%

Open an attribute table for a layer
-----------------------------------

Once the attribute table panel is displayed, you can open the attribute table of each vector layer by clicking on the button situated right to the layer name. This will open a new tab labelled with the layer title which will show the attribute table for the chose layer.

*Opening an attribute table can take some time depending on the data size and complexity.*

.. image:: /images//user-guide-33-attribute-menu-visualize-layer.png
   :align: center
   :scale: 80%


Description of the attribute table functionality
------------------------------------------------

The layer data is shown in a **paginated table**. By default, the table shows 100 lines at a time. You can change this behaviour by using the list situated in the bottom left side of the tab content.

The table of data can be **ordered by a field** by clicking on the column corresponding to . If you click again on the column, the order will be reversed.

.. image:: /images//user-guide-34-attribute-order-line.png
   :align: center
   :scale: 80%


Actions on lines
~~~~~~~~~~~~~~~~

When you **click on a table line**, the line will be displayed with a border to help viewing which line is **highlighted**.

If the publisher has enabled the **popup** for the layer, you will be able to see the content of the popup for the highlighted feature by clicking on the (i) button (labelled with *Display info* when hovering the mouse on it). This will open a panel right to the table, which will display the detailed information on the highlighted table line. Furthermore:

* Clicking on another line will refresh the right panel content with the new highlighted feature.
* Clicking back on the (i) button or on the cross situated at the top right side of the information panel will hide the panel.

Each line of the table shows some buttons at the left side:

* **Select** button : when clicked, the corresponding feature is selected. You can select many lines by using this button on different lines. The selected features will be displayed in a different style on the map, usually with a Yellow color. You can click again on the "Select" to unselect a selected feature.
* **Zoom** button : clicking on this button will zoom to the corresponding geometry in the map. The scale will be chosen so that the feature geometry uses most of the available space.
* **Center** button : clicking on this button will just pan the map to the corresponding feature, without changing scale.

.. image:: /images//user-guide-35-attribute-panel-options.png
   :align: center
   :scale: 80%

More about selection tools
~~~~~~~~~~~~~~~~~~~~~~~~~~

You can also select a layer object by **displaying the popup** for this object (if the map publisher has enabled the popup for the layer, a click on the map will show a popup window containing detailed information on the clicked feature). Inside the popup, if you can see the select button, you can use it to select only this object. Previous selection will be replaced by only this object.

.. image:: /images//user-guide-36-attribute-popup-selection.png
   :align: center
   :scale: 80%

When one or more lines have been selected in the attribute table (they become yellow), you can use the black "arrow up" button situated above the table to **move the selected lines at the top of the table**.

You can **unselect all the selected objects** by clicking on the "white star" button situated above the table.

.. image:: /images//user-guide-37-attribute-select-top.png
   :align: center
   :scale: 80%

Quickly search through data
~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can **filter the lines displayed** in the table by entering some letters in the **Search field** situated at the top left side of the tab content. If you want to see all the features again, just erase the search field content manually or by clicking on the cross button situated inside the field.

The text entered in the search field launches a search among the data for **all the fields of the table.**

Note that only the content of the table will be restricted to the lines matching your textual search. **The objects on the map will not be filtered dynamically** (but you could use select and filter to do so, see below)

Once you have filtered some data in the attribute table by entering some text in it, **you can easily select them all** by clicking on the "black star" button labelled "Select searched lines". This will select all the corresponding objects in the attribute table (display them in yellow) and also change their color in the map (usually in yellow too, depending on the configuration done by the map publisher)

.. image:: /images//user-guide-38-attribute-search.png
   :align: center
   :scale: 80%

Filter data
~~~~~~~~~~~

When you have selected one or more objects in the layer attribute table, you can then **filter the data displayed in Lizmap** for this layer. To do so, just click on the "Funnel" button labelled "Filter" situated above the table (only available if some the selection contains at least one object).

Filtering will have the following consequences:

* The attribute table will **show only the filtered data**
* The Search input field will allow to **search only among filtered data**
* The map will show **only the filtered objects**
* The child layers linked with relations (and also published in the attribute table tool) will be filtered too. We call it "cascading filtering". For example, the bus stops could be filtered automatically if you have filtered one bus line, to show only the ones served by the filtered line.
* The filtered layers will be marked in the left panel legend with an orange background, and a new orange "Funnel" button will be displayed above the legend.

You can cancel the filter to go back to previous state:

* by clicking on the orange "Funnel" button at the top of the legend in Lizmap left panel
* by clicking back on the filter button just above the attribute table concerned by the filter

.. image:: /images//user-guide-39-attribute-filter.png
   :align: center
   :scale: 80%

When exporting the map view with the permalink tool (situated in the menu bar), **the filter will be activated** in the linked map and the users won't be able to easily unfilter the data : the unfilter button will not be displayed in Lizmap interface
The only way would be to remove the filter parameters from the permalink URL. **This is not a safe way to protect some data, but a way to focus on some data only**.



More complex scenarios : relations between layers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

todo



