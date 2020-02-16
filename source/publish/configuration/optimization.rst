Optimization
============

General concepts
----------------

Rendering speed is crucial for a webGIS, much more so than for a desktop application:

* web users expect to have everything available almost immediately
* each user can sends requests to the same application; if you have tens or hundreds of users, you can easy understand that optimising your web application is an important task.

You have to think to a web publication for many users rather than the display of a map to a single user.

By default, for each QGIS layer you add to your Lizmap project, you can choose from the Lizmap plugin whether to toggle the layer visibility on (checkbox *Toggled?*) at the startup of the application. You have to be careful not to abuse this feature, because if the project contains e.g. 30 layers, Lizmap at startup will send a request to QGIS server for each of them. If the checkbox *Single Tile?* is ticked, this will request 30 images of the size of your browser window. If not, Lizmap, through OpenLayers, will request 30 series of tiles (about 250 by 250 pixel). Each tile is an image, and is created as a function of the total window size and zooming level. Therefore, subsequent users will zoom in the same area, the tiles already generated will be reused. The tiles can be cached with two non exclusive systems:

* *server side*, on the machine where QGIS server and Lizmap are installed. If the tile has been requested and generated earlier, and not expired, Lizmap will reuse it and send it to the client, avoiding a new request to QGIS server
* *client side*: the tiles will be saved in the browser cache, and reused until they expire. This avoid both the request to QGIS server and the internet traffic.

The server cache has to be generated. In Lizmap <3, the only way of creating the tiles is to zoom and pan the whole map, and wait until all the tiles have been displayed. This is obviously impractical for projects covering a large area, with many zoom levels. in Lizmap >=3 we have developed a command line tool to generate all the tiles, or a selection of them.

To optimize the performance, is therefore important to understand how Lizmap uses the tiles to be displayed.

Let's say you have a screen of 1280 by 768 pixels. If you have all your layers tiled, Lizmap has therefore to show about 5 by 3= 15 tiles (256 by 256 pixel each) per layer, and more for a larger screen, now common. If surrounding tiles are only partially shown, the total number will be even greater. An average of 20 tiles per layer is a reasonable estimate. With 30 layers, as in our example, this will mean a total of about 20 by 30= 600 tiles (therefore, 600 requests to Lizmap server) per user, at each startup of Lizmap and for every zoom & pan. If you have 10 concurrent users, this gets quite heavy for the server, if the cache has not been generated previously, and QGIS server has therefore to create them. The time required for each tile will depend heavily on the performance of the server and the complexity of the project.

The size of each tile will depend on:

* the type of data (single raster or vector, or combination of several layers)
* the image format chosen (PNG, JPEG)

A typical tile could be around 30 Kb. In our example, the client will therefore download about 20 by 30= 600 Kb per layer, which, for 30 layers, will give a grand total of about 18 Mb, which is heavy both for the server (lots of connection bandwidth consumed) and for the users (long delay, even with a reasonably fast connection).

These calculations show clearly that to achieve good performances in webmapping you have to make choices, and simplify as much as possible.

If one looks, for instance, at the approach taken by Google Maps or similar services, it is quite obvious that, besides having powerful servers, they have simplified as much as possible: only one tile series as a base layer, and very few additional layers (and not all at the same time). Even if you cannot create such a simple map, it's important nonetheless knowing which layers should absolutely be shown at the first display of the map, and which compromises are acceptable for your users.

If your project has 50 layers to be switched on and off, the vast majority of your users will never select most of them. Of course, there are real use cases where individual layers must be displayed selectively, and it is therefore not possible to group them to reduce the number of layers displayed.

To optimize your application as much as possible, we suggest you to:

* Create separate QGIS projects, and therefore different Lizmap maps, for different aims, thus grouping data in logical themes. For instance, a map about urban development with maybe 10 layers and one about environment, with about 5 layers, are usually more readable, and much faster, than a single overcomplex project with all the data. Adding a small image for each project will help users to select the relevant project at first sight. You can also share some of the layers among different projects, through the embedding mechanism in QGIS.
* Use the option *Maps only* in the administrator web interface. This option allows the user to switch automatically from one map to another, through the button *Home*, maintaining as much as possible the localization and the zooming level. In this case, the Lizmap welcome page with the list of projects and their thumbnails is not displayed, and the user is directed automatically to one of the projects, at the administrator choice.
* Do not show all the layers at startup (deactivate the checkbox *Toggled?* as described above). Only very important layers should be visible by default, and users should activate only the layer they need. This allow a sensible reduction in the number of requests, and of the total network traffic.
* Create groups of layers, and use the option *Group as layer?* in Lizmap plugin. Generally a series of layers of the same general theme can be displayed as a whole, with an appropriate choice of styles. In this case, Lizmap will only show one checkbox for the whole group, and more importantly it will request only one series of tiles for the whole group, thus reducing the number of tiles and server requests, and the total volume of data to be downloaded. The legend of the group will be displayed.
* Use the option *Single Tile?* for some layers. In this case, Lizmap will request only one image per layer, of about the size of the screen, instead of a series of tiles. This will therefore greatly reduce the number of requests to the server. For instance, in our example above, without the optimizations described, if all the layers are displayed, every user will request 30 images (one per layer) for every zoom or pan, instead of 480. The total size of data to be downloaded is however similar. On the other hand, different users will be very unlikely to request exactly the same image, therefore using a cache is pointless in this case, and is avoided by Lizmap (the two options are mutually exclusive). The optimal choice (single tile vs. tiled) is different for different layers. For instance, a complex base layer, created by combining 15 individual layers, will be best used as a group (*Group as layer?*), tiled and cached. A simple linear layer, like a series of bus lines, can be displayed as a single tile.
* Use the option *Hide checkboxes for groups*: this avoids the users to click on a group with e.g. 20 layers without really needing it, thus firing a big series of requests to the server. In any case, avoiding groups of more than 5-10 layers is usually good practice.
* Optimize the data and the QGIS project. As mentioned above, publishing a map over the internet will change your point of view: as said, you have to remember that many users can hit the server in parallel, so avoiding to overload it is crucial to:

  * create a spatial index for all your vector layers
  * pyramidize all your raster layers (except the very small ones)
  * only display data at appropriate scale: for instance, displaying a detailed building layer at 1:500,000 is meaningless, as the image is almost unreadable, and puts a lot of stress on the server
  * use simplified version of a layer to display it at different scales. You can then group the original layer (to be displayed e.g. around 1:1,000) with the simplified versions (to be displayed e.g. around 1:10,000, 1:50,000, etc.), and *Goup as a layer* to let the user see this as a single layer, using the most appropriate data at each scale
  * be careful about On The Fly (OTF) reprojection. If, for instance, you display data in Lambert 93 (EPSG:2154) on a base map from OpenStreetmap or Google (in Pseudo Mercator, EPSG:3857), QGIS Server needs to reproject rasters and vectors before generating the map. This may have an impact in rendering times for large and complex layers. In France, you can avoid reprojection by using the base map from IGN Géoportail directly in EPSG:2154
  * be aware of the fact that certain rendering options (e.g. labels, expressions, etc.) can be very demanding from the server
  * if you use PostGIS, optimize it: always add spatial indexes, indexes for filtered fields, for foreign keys, appropriate parameters for the configuration of PostgreSQL, possibly a connection through Unix socket instead of TCP/IP (you can do this through the use of services), etc.
  * use an appropriate image format. For the base layers, where you do not need transparency JPEG is usually the best option: the tiles will be smaller, and faster to download. For other layers, try smaller depth PNGs (16bit or 8bit): for some symbolizations, the visual result may be the same, and the tiles smaller. Have a check to see if the image quality is acceptable in your case
  * Use server side simplification if possible. Read :ref:`server_side_simplification`.

* Upgrade your server. This is always an option, but is often useless if you did not optimize your project as described above. In any case, a low end server (e.g. 2 Gb RAM, 2 cores at 2.2 GHz) is unsuitable. A fast quad-core with 8 Gb RAM is a reasonable minimum. Avoid installing QGIS server and Lizmap on Windows, it's more complex and slower.

.. note::
    In Lizmap 3 you'll find several improvements that will help optimizing your installation:
        * a tool for the preparation of the server cache, through the use of a WMTS protocol. In addition, this will allow to use the cached layers as WMTS layers in QGIS desktop
        * avoiding the automatic download of the legends at startup, and at every zoom level; this will be done exclusively on demand, if the legend is displayed, thus saving one request per layer for each zoom
        * code optimization.

In detail: how to activate the caches
-------------------------------------

The Lizmap plugin *Layers* tab allows you to enable for each layer or group as a layer the cache (client and server side) for generated images.

* Activating the cache server side

This feature is not compatible with the option *single tile*. Lizmap Web Client can dynamically create a cache tiles on the server.
This cache is the storage of the images already generated by QGIS-Server on the server.
The Lizmap Web Client application automatically generates the cache as the tiles are requested.
Enable caching can greatly lighten the load on the server, since we do not want more QGIS-Server tiles that have already been made.

To activate it, you must:

* check the box :guilabel:`Server tile cache`
* specify the expiration time of the cache server in seconds: **Expiration (seconds)**.
  0 means no expiration on the server, the tile will be kept on the server until the cache is cleared.

The **Metatile** option allows you to specify image size in addition for generating a tile.
The principle of **Metatile** is to request the server for a bigger image than hoped, to cut it to the size of the request and return it to the Web client.
This method avoids truncated labels at the edges and discontinuities between tiles, but is more resource intensive.
The default value is *3,3*, an image whose width and height are equal to 5 times the width and height request.
This option is useless for rasters.

* Activating the cache client side

The **Browser client cache** option allows you to specify an expiration time for the tiles in the Web browser (Mozilla Firefox, Chrome, Internet Explorer, Opera, etc.) cache in seconds.
When browsing the Lizmap map with the browser, it stores displayed tiles in its cache.
Enable client cache can greatly optimize Lizmap because the browser does not re-request the server for tiles already in cache that are not expired.
Values 0 and 1 are equivalent, and do not activate the option.

We suggest to set to the maximum value (1 month equals to 24 x 3600 x 30 = 2,592,000 seconds), except of course for layers whose data changes often.

.. note::
   * **The cache must be activated only once mastered rendering**, when you want to move the project into production.
   * **The 2 cache modes, Server and Client, are completely independent** of one another. But of course, it is interesting to use the two together to optimize the application and free server resources.

.. _lizmap-cache-centralized:

Centralizing the cache with the integration of groups and layers from a master project
--------------------------------------------------------------------------------------

In QGIS, it is possible to integrate in a project, groups or layers from another project (which will be called "parent"). This technique is interesting because it allows you to set the properties of the layers once in a project and use them in several other, for example for baselayers (In the "son" projects that integrate these layers, it is not possible to change the properties).

Lizmap uses this feature to centralize the tiles cache. For all son projects using integrated layers of the parent project, Lizmap requests QGIS-Server tiles from the parent project, not form son projects. The cache will be centralized at the parent project, and all son projects that use layers benefit shared cache.

To use this feature, you must:

* publish the parent QGIS project with Lizmap

  - you must **choose the right announced extent** in the *OWS Server* tab from project properties, because this **extent will be reused identically in son projects**.
  - you must **configure the cache** for the layers to integrate. Also, note the options chosen here (image format, metatile, expiration) for use as such in the son projects.
  - It is possible to hide the project from the main page of Lizmap with the check box *Hide the project Web Client Lizmap* in the plugin 'Map' tab.

* open the son project, and integrate layers or groups in this project, for example orthophoto. Then you must:

  - verify that the **announced extent** in the QGIS project properties / OWS Server is **exactely the same as the parent project**.
  - you must **configure the cache** for the integrated layer **with exactly the same options as those selected from the parent project**: image size, expiration, metatile.
  - you must set the Lizmap id of the **Source repository** of the parent project (The one configured in the Lizmap Web Client administration interface).
  - the code of the "Source project" (the name of the parent QGIS project without the .qgs extension) is automatically entered for layers and integrated groups.

* Publish the son project to the Lizmap Web Client as usual.
