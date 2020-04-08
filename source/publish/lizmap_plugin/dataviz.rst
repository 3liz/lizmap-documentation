.. include:: ../../substitutions.rst


Dataviz - display some graphs
=============================

Principle
---------

With the dataviz panel, you can create a few kinds of graph with only a few clicks:

- scatter
- pie
- histogram
- box
- bar
- histogram2d
- polar
- sunburst |lizmap_3_4|
- HTML |lizmap_3_4|

.. image:: /images/publish-01-dataviz-interface.jpg
   :align: center
   :scale: 80%

Prerequisites
-------------

|wfs_layer|

Configuring the tool
--------------------

.. tip::
    You can start using the plugin ``DataPlotly`` to create your graph in QGIS itself.
    So you can have a preview about what is possible *more or less* about dataviz with your layers.
    But keep in mind that Lizmap and DataPlotLy, even if's using the same dataviz engine (plotly https://github.com/plotly/plotly.py ), features are different between these two tools.

You can easily configure it with the plugin Lizmap in QGIS in the :guilabel:`Dataviz` panel.

At the layer level
^^^^^^^^^^^^^^^^^^

- To enable a layer with dataviz capabililities:

    1. |add_layer|
    2. Select the type of chart to add. According to your choices, the form will adapt it self.
    3. **Title** : Here you can write the title you want for your chart.
    4. **Description** : The description of the chart. You can include HTML.
    5. *Select the layer* in the drop-down list.
    6. **X field** : The X field of your graph. It might be empty for a few types.
    7. **Aggregation** : For a few types of charts like bar or pie, you can chose to aggregate the data in the graph. There are a few aggregate functions available - average(avg), sum, count, median, stddev, min, max, first, last.
    8. **Traces** : Depending of the kind of chart, you can add one or many traces : the Y field of your graph.
    9. Depending of the kind of chart, there is now different options.
    10. **Display filtered plot in popups of parent layer** : if you check this checkbox, the children of your layer will get the same graph as the parent plot but filtered only for them. It's useful if you want to see the statistics of one entity instead of all.
    11. **Only show child popup** : The main graph will not be shown in the main container and only the filtered graph of the relation of the layer will be displayed in the popup when you select the element.
    12. **Display the legend**, sometimes, the legend is not necessary.
    13. **Display plot only when the layer is visible**.

- |edit_layer|
- |remove_layer|
- |move_up_down_layer|
- |field_alias|

.. image:: /images/interface-publisher-dataviz.jpg
    :align: center
    :scale: 80%


At the project level
^^^^^^^^^^^^^^^^^^^^

1. You have the possibility to change the value to **dock**, **bottomdock** or **right-dock** these options change where your dataviz panel will be located in your Lizmap's project. You have 3 positions available, at the right of the screen, bottom and right.

2. You have the possibility to write in HTML the layout of the container of your charts. If you are proficient in the HTML language, there are a lot of possibilities and you can customize your container the way you want.

For instance, this bootstrap HTML code will produce the layout below:

.. code-block:: html

    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span6">$0</div>
            <div class="span6">$1</div>
        </div>
        <div class="row-fluid">
            <div class="span12">$2</div>
        </div>
    </div>


.. image:: /images/publish-03-dataviz-html-example.jpg
   :align: center
   :scale: 80%


Examples
--------

You can visit the Cats project on https://demo.lizmap.com
