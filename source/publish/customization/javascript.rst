.. meta::
   :keywords: js,script,javascript,code

.. _adding-javascript:

Adding your own JavaScript
==========================

.. contents::
   :depth: 3

Principle
---------

Adding some JavaScript (JS) is useful for a variety of advanced usage.
For instance, you can:

    - hide some UI elements that you don't want to display by default
    - add a custom button in the UI
    - add a popup when the project is opened (to display funders, credits…)
    - avoid people being able to download elements of the page by right clicking on them, and of course much more.

Prerequisites
-------------

* This function needs to be activated by the administrator of the Lizmap instance
  on the :ref:`repository page <lizmap-repository>`.
* The :file:`media` directory. Read how to use :ref:`media` folder in Lizmap.

Configuring the tool
--------------------

* In your repository (e.g. :file:`/home/data/repo1/myproject.qgs`), you should have these directories::

    media
    |-- js
      |-- myproject
      |-- default

* All the JavaScript code you copy in the :file:`/home/data/rep1/media/js/myproject/` directory will be executed by
  Lizmap for this **specific** project only.
* All the JavaScript code in ``default`` will be executed for **all** projects.
* To allow the execution of JavaScript code, in the Lizmap admin interface, you **must** add the privilege
  :guilabel:`Allow themes for this repository`.

.. tip::
    It's possible to temporary disable the loading of additional JavaScript by adding a parameter in the URL :
    ``&no_user_defined_js=1``.

Video tutorial
--------------

`This video <https://www.youtube.com/embed/xQQ34nvRZ-w>`_ is an quick start how to add a JavaScript to change the
default panel in Lizmap.

.. raw:: html

    <p align="center"><iframe width="560" height="315" src="https://www.youtube.com/embed/xQQ34nvRZ-w" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe></p>

Library of scripts
------------------

You can find some examples in the `JavaScript library <https://github.com/3liz/lizmap-javascript-scripts>`_ on GitHub.

Also, in the directory :file:`lizmap-web-client/lizmap/install/qgis/media/js/` (or in
`GitHub <https://github.com/3liz/lizmap-web-client/tree/master/extra-modules/lizmapdemo/qgis-projects/demoqgis/media/js/montpellier>`_),
you can find examples of suitable JavaScript code.

Remove the extension ``.example`` and copy them to your :file:`media/js/default/` folder to activate them.

API documentation
-----------------

An automated generated documentation of the JavaScript API is available on `docs.3liz.org <https://docs.3liz.org/lizmap-web-client/>`_.

Available Javascript events
---------------------------

The Javascript code can use many events fired by Lizmap Web Client. Here is a list of all the events available, with the
returned properties.

.. csv-table:: Lizmap Web Client available events
   :header: "Event name", "Description", "Returned properties"

   "treecreated","Fired when layer tree has been created in legend panel",""
   "mapcreated","Fired when OpenLayers map has been created",""
   "layersadded","Fired when Openlayers layers have been added",""
   "uicreated","Fired when interface has been created",""
   "dockopened","Fired when a dock is opened (left panel)","id"
   "dockclosed","Fired when a dock is closed (left panel)","id"
   "minidockopened","Fired when a mini-dock ( right container for tools) is opened","id"
   "minidockclosed","Fired when a mini-dock is closed","id"
   "bottomdockopened","Fired when the bottom dock is opened","id"
   "bottomdockclosed","Fired when the bottom dock is closed","id"
   "lizmapbaselayerchanged","Fired when the baselayer has been changed","layer"
   "lizmapswitcheritemselected","Fired when a layer has been highlighted in the layer legend panel","name | type | selected"
   "layerstylechanged","Fired when a layer style has been changed","featureType"
   "lizmaplocatefeaturecanceled","Fired when the user has canceled the locate by layer tool","featureType"
   "lizmaplocatefeaturechanged","Fired when the user has selected an item in the locate by layer tool","featureType | featureId"
   "lizmappopupdisplayed","Fired when the popup content is displayed",""
   "lizmappopupallchildrendisplayed","Fired when the all children popups are displayed","parentPopupElement | childPopupElements"
   "lizmappopupdisplayed_inattributetable","Fired when the popup content is displayed in attribute table (right sub-panel)",""
   "lizmapeditionformdisplayed","Fired when a edition form is displayed","layerId | featureId | editionConfig"
   "lizmapeditionfeaturecreated","Fired when a layer feature has been created with the edition tool","layerId"
   "lizmapeditionfeaturemodified","Fired when a layer feature has been modified with the edition tool","layerId"
   "lizmapeditionfeaturedeleted","Fired when a layer feature has been deleted with the edition tool","layerId | featureId"
   "attributeLayersReady","Fired when all layers to be displayed in the attribute layers tool have been set","layers"
   "attributeLayerContentReady","Fired when a table for a layer has been displayed in the bottom dock","featureType"
   "layerfeaturehighlighted","Fired when a feature has been highlighted in the attribute table ( grey rectangle ). Firing this event manually forces a refresh of child tables if any exist for the layer","sourceTable | featureType | fid"
   "layerfeatureselected","Fire this event to trigger the selection of a feature for a layer, by passing feature id. Once the selection is done, the event layerSelectionChanged is fired in return.","featureType | fid | updateDrawing"
   "layerfeaturefilterselected","Fire this event to trigger the filtering of a layer for the selected features. You must select some features before firing this event. Once the filter is applied, Lizmap fires the event layerFilteredFeaturesChanged in return.","featureType"
   "layerFilteredFeaturesChanged","Fired when a filter has been applied to the map for a layer. This event also trigger the redrawing of the map and the attribute tables content.","featureType | featureIds | updateDrawing"
   "layerFilterParamChanged","Fired when the WMS requests parameters have changed for a layer. For example when a STYLE or a FILTER has been modified for the layer.","featureType | filter | updateDrawing"
   "layerfeatureremovefilter","Fire this event to remove any filter applied to the map. Once done, the event layerFilteredFeaturesChanged is fired back, and the map content and attribute tables content are refreshed.","featureType"
   "layerSelectionChanged","Fired when the selection have been changed for a layer. This also trigger the redrawing of attribute table content and map content","featureType | featureIds | updateDrawing"
   "layerfeatureselectsearched","Fire this event to select all the features corresponding to the displayed lines of the attribute table, which can be visually filterd by the user by entering some characters in the search text input.","featureType | updateDrawing"
   "layerfeatureunselectall","Fire this event to remove all features from selection for a layer. Once done, Lizmap responds with the event layerSelectionChanged","featureType | updateDrawing"
   "lizmapexternalsearchitemselected","Fired when the user has selected an item listed in the results of the header search input","feature"
   "actionResultReceived","Fired when a Lizmap popup action has been performed and the result has been received","layerId | featureId | action | features"

There are also some variables which are available.

.. csv-table:: Lizmap Web Client available variables
   :header: "Variable name", "Description"

   "lizUrls.media","URL to get a media"
   "lizUrls.params.repository","Name of the current repository"
   "lizUrls.params.project","Name of the current project"

Examples
--------

Legend API
^^^^^^^^^^

For a given layer ``buildings`` :

.. code-block:: javascript

    var layer = lizMap.mainLizmap.state.rootMapGroup.getMapLayerByName('buildings');
    // Name of the current loaded style
    layer.wmsSelectedStyleName
    // Toggle true or false the layer in the legend
    layer.checked = true;


Please have a look to existing online demo, like the
`Paris by night <https://demo.lizmap.com/lizmap/index.php/view/map?repository=javascript&project=lampadaires>`_

Disable right click
^^^^^^^^^^^^^^^^^^^

Add a file named e.g. :file:`disableRightClick.js` with the following code:

.. code-block:: javascript

   lizMap.events.on({
      uicreated: function(e) {
         $('body').attr('oncontextmenu', 'return false;');
      }
   });

* If you want this code to be executed for all projects of your repository, you have to copy the file in the directory
  :file:`/home/data/rep1/media/js/default/` rather than in :file:`/home/data/rep1/media/js/myproject/`.

Send current login user-ID
^^^^^^^^^^^^^^^^^^^^^^^^^^

An example allowing you to send current login User-ID (and/or other user data) to PostgreSQL table column, using edition
tool:

.. code-block:: javascript

   var formPrefix = 'jforms_view_edition';

   // Name of the QGIS vector layer fields which must contain the user info
   // In the list below, replace the right side by your own fields in Lizmap
   var userFields = {
      login: 'your_lizmap_user_login_field',
      firstname: 'your_lizmap_user_firstname_field',
      lastname: 'your_lizmap_user_lastname_field'
   };


   lizMap.events.on({

      'lizmapeditionformdisplayed': function(e){

         // If user is logged in
         if( $('#info-user-login').length ){
               // Loop through the needed fields
               for( var f in userFields ){
                  // If the user has some data for this property
                  if( $('#info-user-' + f).text() ){
                     // If the field exists in the form
                     var fi = $('#' + formPrefix + '_' + userFields[f]);
                     if( fi.length ){
                           // Set val from lizmap user data
                           fi.val( $('#info-user-' + f).text() )
                           // Set disabled
                           fi.hide();
                     }
                  }
               }
         }

      }

   });


URL of a static file
^^^^^^^^^^^^^^^^^^^^

If you want to get the URL of a static file, located in the :ref:`media` folder:

.. code-block:: javascript

    var media = '/media/image/logo.jpg';
    // It can also be a media located in the common media folder such as
    // var media = '../media/logo.png';
    var url = lizUrls.media + '?repository=' + lizUrls.params.repository + '&project=' + lizUrls.params.project + '&path=' + media;
    // console.log(url);
    var image  = '<img src="' + url + '" title="Logo" style="display:inline;height:80px;margin:20px 10px;" />';

It's possible to use a function from the OpenLayers library to help building the URL :

.. code-block:: javascript

   var mediaUrl = OpenLayers.Util.urlAppend(
        lizUrls.media,
        OpenLayers.Util.getParameterString({
            "repository": lizUrls.params.repository,
            "project": lizUrls.params.project,
            "path": "picture.png"
        })
   );
