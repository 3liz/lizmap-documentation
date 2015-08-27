===============================================================
Cache management as administrator
===============================================================

Lizmap Web Client can automatically generate a tile cache by the server as and when users access maps. In some cases it is desirable to remove the server cache, for example, when the style changes have been made for some spatial layers published in Lizmap Web Client. For this, two solutions are possible:

Remove all the cache by Lizmap repository
===================================================

In the administration interface, The **Lizmap configuration** menu lists configured *Lizmap repository*. For each repository, the administrator can delete the cache for all layers of all the projects repository by clicking the button **Empty cache**.

Delete the cache, layer by layer, for each Lizmap project
==============================================================

When the administrator is connected and consults a Lizmap map, a **little red cross** is displayed to the right of the name of each layer that is configured to be server cached. Clicking on the cross allows, after confirmation, delete the server cache only for this layer of the QGIS project. Only logged administrator sees these red crosses and has the right to start the delete.
