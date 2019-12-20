Dataviz - display some graphs
=============================

Principle
---------

In the 3.2 version of Lizmap, a way to show charts in Lizmap is implemented. You will be able to create a few kinds of graph (scatter, pie, histogram, box, bar histogram2d, polar) with only a few clicks.

.. image:: /images//publish-01-dataviz-interface.png
   :align: center
   :scale: 80%

Configuring the tool
--------------------

You can easily configure it with the plugin Lizmap in QGIS in the Dataviz panel.

.. image:: /images//publish-02-dataviz-interface-plugin.png
    :align: center
    :scale: 80%

**1** :
You have the possibility to change the value to **dock**, **bottomdock** or **right-dock** these options change where your dataviz panel will be located in your Lizmap's project. You have 3 positions available, at the right of the screen, bottom and right.

**2**:
Here, you have the possibility to write in HTML to change the style of the container of your charts. If you are proficient in the HTML language, there are a lot of possibilities and you can customize your container the way you want.

.. image:: /images//publish-03-dataviz-html-example.png
   :align: center
   :scale: 80%

**3**:
This table contains all the layers you have configured to be able to show statistics in your Lizmap project. All details about the configuration are shown in this table. You have to use it if you want to remove a layer, you will need to click on a line of the table then click on the button **remove a layer** at the bottom on the panel.

**4**:
To add a graph, you have to configure it in this part of the panel.

   * **Type** : You can choose the type of your graph, the available options are - scatter, box, bar, histogram, histogram2d, pie and polar.
   * **Title** : Here you can write the title you want for your graph.
   * **Layer** : You chose which layer you want to make a graph with.
   * **X field** : The X field of your graph.
   * **Y field** : The Y field of your graph.
   * **Group?** : For a few types of charts like 'bar' or 'pie', you can chose to aggregate the data in the graph. There are a few aggregate functions available - average(avg), sum, count, median, stddev, min, max, first, last
   * **Color field** : you can choose or not a color field to customize the color of each category of your chart. If you want to do it, you need to check the checkbox, then chose the field of your layer which contains the colors you want to use. The color can be written like 'red' or 'blue' but it can be an HTML color code like '#01DFD7' for example.
   * **2nd Y field** : You can add a second Y field, it does not work for every type of graph, it's only working for histogram2d.
   * **Color field 2 ?** : You can chose the color of the second Y field the same way you chose the one for his first Y field.
   * **Display filtered plot in popups of parent layer** : if you check this checkbox, the children of your layer will get the same graph as the parent plot but filtered only for them. It's useful if you want to see the statistics of one entity instead of all.
   * **Only show child** : The main graph will not be shown in the main container and only the filtered graph of the relation of the layer will be displayed in the popup when you select the element.

When all the configuration is done, you have to click on the button **add a layer** at the bottom of the window.
