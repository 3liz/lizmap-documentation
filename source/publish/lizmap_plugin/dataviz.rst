.. include:: ../../substitutions.rst

Dataviz - display some graphs
=============================

.. contents::
   :depth: 3

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

.. include:: ../../shared/wfs_layer.rst

Video tutorial
--------------

This video is an quick start how to setup a filtered chart in a parent popup:

https://www.youtube.com/embed/aGJnScdkEtE

Configuring the tool
--------------------

.. tip::
    You can start using the plugin ``DataPlotly`` to create your graph in QGIS itself.
    So you can have a preview about what is possible *more or less* about dataviz with your layers.
    But keep in mind that Lizmap and DataPlotLy, even if's using the same dataviz engine
    (`plotly <https://plotly.com/>`_), features are different between these two tools.

You can easily configure it with the plugin Lizmap in QGIS in the :guilabel:`Dataviz` panel.

At the layer level
^^^^^^^^^^^^^^^^^^

.. image:: /images/interface-publisher-dataviz.jpg
    :align: center
    :scale: 80%

- To enable a layer with dataviz capabilities:

    1. .. include:: ../../shared/add_layer.rst
    2. Select the type of chart to add. According to your choices, the form will adapt it self. Read below the kind of charts.
    3. **Title** : Here you can write the title you want for your chart.
    4. **Description** : The description of the chart. You can include HTML.
    5. *Select the layer* in the drop-down list.
    6. **X field** : The X field of your graph. It might be empty for a few types.
    7. **Aggregation** : For a few types of charts like bar or pie, you can chose to aggregate the data in
        the graph. There are a few aggregate functions available - average(avg), sum, count, median, stddev, min, max, first, last.
    8. **Traces** : Depending of the kind of chart, you can add one or many traces : the Y field of your graph.
    9. Depending of the kind of chart, there is now different options.
    10. **Layout** : The layout can be customized. It must be a JSON dictionary.
        You can read the `documentation of Plotly <https://plotly.com/javascript/reference/layout/>`_ about the layout configuration
    11. **Display filtered plot in popups of parent layer** : if you check this checkbox, the children of your
        layer will get the same graph as the parent plot but filtered only for them.
        It's useful if you want to see the statistics of one entity instead of all.
    12. **Only show child popup** : The main graph will not be shown in the main container and only the filtered
        graph of the relation of the layer will be displayed in the popup when you select the element.
    13. **Display the legend**, sometimes, the legend is not necessary.
    14. **Display plot only when the layer is visible**.
    15. Some options might be visible or not according to the kind of chart, like choosing for horizontal/vertical
        layout for a bar chart.

- .. include:: ../../shared/edit_layer.rst
- .. include:: ../../shared/remove_layer.rst
- .. include:: ../../shared/move_up_down_layer.rst
- .. include:: ../../shared/field_alias.rst


At the project level
^^^^^^^^^^^^^^^^^^^^

..  image:: /images/interface-dataviz.jpg
   :align: center

1. You have the possibility to change the value to **dock**, **bottomdock** or **right-dock** these options change
where your dataviz panel will be located in your Lizmap's project. You have 3 positions available, at the
right of the screen, bottom and right.

2. You have the possibility to write in HTML the layout of the container of your charts. If you are proficient
in the HTML language, there are a lot of possibilities and you can customize your container the way you want.

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

JSON layout
^^^^^^^^^^^

The layout option, allows you to configure many options by writing up a JSON object.
See the full reference on `Plotly <https://plotly.com/javascript/reference/layout/>`_.

The following examples show how to use some properties depending of the layout property:

* Add units in the Y (vertical) axis numbers:

.. code-block:: javascript

    // Add " ha" suffix
    {"yaxis": {"ticksuffix": " ha"}}


* Remove labels in the X (horizontal) axis:

.. code-block:: javascript

    // Hode X labels. Use yaxis for Y labels
    {"xaxis": {"showticklabels": false}}


* Remove the automatic `k`, `M` or `G` suffix (ex: `10 M`) for big number in the axis and in the hover tooltip:

.. code-block:: javascript

    {"yaxis": {"tickformat": ",.2f"}}

* Order of the bars for a bar chart. Use ascending or descending values:

.. code-block:: javascript

    // By ascending X value
    {"xaxis": {"categoryorder": "category ascending"}}

    // By descending bar height (total Y value)
    {"xaxis": {"categoryorder": "total ascending"}}


* Set margins. Use `l` for left, `t` for top, `r` for right and `b` for bottom:

.. code-block:: javascript

    // Shift the plot to the right (to display big Y axis labels)
    {"margin": {"l": 70}}


* Define font properties:

.. code-block:: javascript

    // Change X axis font size
    {"xaxis": {"tickfont": {"size": 10}}}


* You can combine any of the properties, for example:

.. code-block:: javascript

    {
        "xaxis": {
            "categoryorder": "total ascending"
            "tickfont": {
                "size": 10
            }
        },
        "yaxis": {
            "showticklabels": false
        }
    }

Other customisation with JavaScript scripts
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

We can also modify charts with some JavaScript scripts.

* You can decide to not have any number after the comma for the first chart (id: dataviz_plot_0), for example:

.. code-block:: javascript

    lizMap.events.on({
        'datavizplotloaded': (evt) => {
            if( evt.id === 'dataviz_plot_0'){
                Plotly.restyle( evt.id, {
                    texttemplate: "%{value:.0f}"
                });
            }
        }
    });

Types of charts
^^^^^^^^^^^^^^^

The dataviz module will aggregate every **traces** for all unique **X** values.

HTML templates
""""""""""""""

A trace must be referenced by ``{$y1}`` where ``1`` is the trace number in the table.

This example below will produce a single colored box, similar to the
`COVID demo <https://demo.lizmap.com/lizmap/index.php/view/map?repository=features&project=covid_19_fr>`_.

.. code-block:: html

    <style type="text/css">
    table.example-table {
        width: 100%;
        font-weight: bold;
        color:#4a4a4a;
        padding: 10px;
        border-spacing: 10px;
        border-collapse: separate;
    }
    table.example-table tr td {
        background-color: #fca487;
        border-radius: 5px;
        border: 10px solid #fff0;
        padding: 10px;
        margin: 10px;
        text-align: center;
    }
    </style>
    <table class="example-table">
        <tbody>
            <tr>
                <td>{$y1}</td>
            </tr>
        </tbody>
    </table>

.. image:: /images/publish-03-dataviz-html-plot.jpg
   :align: center
   :scale: 80%

Miscellaneous
^^^^^^^^^^^^^

* For **pie chart** : the items in the legend are ordered by X as a default behaviour.
* QGIS Field **aliases** are used in the tooltip when hovering the bar or pie slices.

Examples
--------

You can visit the `Cats project <https://demo.lizmap.com>`_.
