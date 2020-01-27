: _locate-by-layer:

Locate by layer
===============

Principle
---------

.. image:: /images/interface-tools-tab-locate.jpg
   :align: center
   :width: 80%

The idea of this tool is to present to the Lizmap Web Client user a drop down list that gives the ability to zoom on one or more spatial objects of the layer.

Use case
--------

Consider a spatial vector layer **districts** contained in the QGIS project. We choose to add these districts in the tool *Locate by layer*, to allow Lizmap Web Client users to quickly position on one of the districts.

Once this layer added in the tool *Locate by layer*, a drop down list of the districts appears on the Lizmap Web interface.

When the Web map user selects one name in this list, the map will automatically refocuses on the selected district and the district's geometry is displayed (optional).

Prerequisites
-------------

.. note:: The layer(s) you want to use must be **published as WFS layer**: check the corresponding box of the *WFS capabilities* in the *OWS Server* tab of the *Project Properties* window.

Configuring the tool
--------------------

To add a layer to this tool:

* **choose the layer** with the first dropdown from the list of the project vector layers
* then **the column that contains the label** you want to display in the dropdown list
* if you want the geometry of the related objects is also displayed on the map when the user selects an item from the list, then check the option *Display the geometry*
* finally click the button **Add layer** to add it to the list.

To remove a layer already configured:

* select the line of the layer you want to remote by clicking on it
* click on the button **Remove layer**.

Hierarchical Lists
------------------

If we take the example of districts, it may be interesting to also provide to the user a *sub-districts* dropdown. We wish that when the user chooses a district, the dropdown of sub-districts is automatically filtered to display only the sub-districts of the chosen district.

For this, there are 2 methods:

* you either have **2 separate vector layers**: one for districts and for sub-districts. So you have to use a **field join** between the two layers to enable automatic filtering lists in Lizmap
* either we have **only 1 layer for sub-districts**, and then you can specify with the plugin a **group field**. Two dropdowns will be created instead of one in the Web application.

.. note:: Up to 3 project layers can be added to the *Locate by layer* tool.
.. note:: Don't forget to check if your configuration of Qgis server is the right one (in Lizmap : My account -> Lizmap configuration -> check if the qgis server version is the right one, if not, you can use the button 'modify' below). If the configuration is not right the location will be wrong!
