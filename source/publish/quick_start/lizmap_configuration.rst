==============================
Set up your project for Lizmap
==============================

.. contents::
   :depth: 3

Install the Lizmap plugin
=========================

The Lizmap plugin is available through the official QGIS project repository:
https://plugins.qgis.org/plugins/lizmap/

To install it, just do it like any QGIS plugin:

* :menuselection:`Menu --> Plugins --> Manage and Install Plugins`
* Search ``Lizmap``
* Install the plugin
* It's available in the menu and toolbar :menuselection:`Web`

.. warning::
    Lizmap QGIS plugin is regularly updated. To enjoy new features or before reporting a bug, be sure to update your plugin.
    In :menuselection:`Menu --> Plugins --> Manage and Install Plugins --> Settings`, check that QGIS will check for updates on a regular basis automatically.

.. image:: /images/introduction-install-lizmap.jpg
   :align: center
   :width: 60%

The plugin is organized in 14 tabs:

* :guilabel:`Information`: some information about the Lizmap project and your servers
* :guilabel:`Map options`: the general options of the map
* :guilabel:`Layers`: the options of each layer
* :guilabel:`Baselayers`: the baselayers used on the Web
* :guilabel:`Locate by layer`: the locating tool
* :guilabel:`Attribute table`: configure the attribute table and the vector selection
* :guilabel:`Layer editing`: which layer can be edited with Lizmap
* :guilabel:`Tooltip layers`: configure the tooltip for some layers
* :guilabel:`Filter layer by user`: setup some filtering based on the current logged user
* :guilabel:`Dataviz`: add some charts and dataviz
* :guilabel:`Time manager`: play an animation based on date or datetime field
* :guilabel:`Atlas`: setup an atlas for the project
* :guilabel:`Filter data with form`: Make some filtering based on attributes
* :guilabel:`Filter data with a spatial layer`: Filter a layer based on another polygon layer for a given user
* :guilabel:`Log`: displays information of performed actions

And it has 5 action buttons:

* :guilabel:`Auto-save` : When ever you click on :guilabel:`Apply` or :guilabel:`Ok` if Lizmap should save the QGIS project too at the same time
* :guilabel:`Help` : open the help in the webbrowser
* :guilabel:`Apply` : write the configuration in the Lizmap file and keep the dialog open
* :guilabel:`Ok` : write the configuration in the Lizmap file and close the dialog
* :guilabel:`Close` : close the dialog without writing the configuration
