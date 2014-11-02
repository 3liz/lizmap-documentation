===============================================================
Prepare a QGIS project for Web
===============================================================

Create your project
===============================================================

Add your data :

* Vector geographic data files

  * ESRI Shapefile
  * MapInfo TAB and MIF/MID
  * GeoJSON
  * etc

* RASTER geographic data files

  * GeoTIFF
  * Arc/Info ASCII Grid
  * netCDF
  * etc

* Geographic data base

  * PostgreSQL / PostGIS
  * MSSQL spatial
  * Oracle locator / spatial

.. image:: ../MEDIA/qgis-montpellier-project.png
   :align: center
   :width: 60%

Organize and manipulate the layes in the legend:

* *Add groups* with a right click in the empty part of the legend: *Add a new group*
* *Move* layers and groups with *drag-and-drop*
* *Rename* layers and groups with the F2 key or the layer properties window
* Manipulate the rendering order:

  * with the *legend layer order*: the upper layers are rendered above the others.
  * by specifying *layer order* with the menu *View > Panels > Layer order*

Add a title to your project and save it in your working directory.

Configure your project for Web
===============================================================

Configure the coordinates reference system, CRS, of your project:

* Select the CRS of your Web map: Sélectionner de préférence le SCR de votre carte Web :

  * EPSG:3857 for Google Mercator
  * EPSG:2154 for Lambert 93
  * etc

* Enable *on the fly CRS transformation*. QGIS can transform rasters and vectors data.

.. image:: ../MEDIA/qgis-montpellier-project-crs.png
   :align: center
   :width: 60%

Configure the Web Geographics Services parameters with the *OWS Server* tab:

* Set the title of your Web Geographics Services
* Add informations like your organization, the owner of the publication owner, the abstract as the description, etc
* Set the maximum extent of your WMS service
* Restrict the CRSs list of your WMS service:

  * at least select the map one
  * you can use the button *Used* to get all the layer CRS and the map one

* Exclure des compositions et des couches si certaines données ne doivent pas être publiées en WMS
* Activer les couches que vous souhaitez publier en WFS et WCS

.. image:: ../MEDIA/qgis-montpellier-project-ows.png
   :align: center
   :width: 60%

Vérifier dans les paramètres du projet, menu *Préférences > Propriétés du projet* ou raccourci CTRL+MAJ+P, que les chemins sont bien enregistrés en relatif.

Configurer vos couches pour le Web
===============================================================

Dans la fenêtre des *Propriétés de la couche*, l'onglet Métadonnées permet de configurer de nombreuses informations pour les Services Géographiques Web :

* Fournir un titre qui pourra être réutilisé ainsi qu'une description et des mots clés
* Préciser l'attribution pour respecter la licence des données
* Ajouter l'URL de la fiche de métadonnées si celle-ci est accessible

.. image:: ../MEDIA/qgis-montpellier-project-tram-layer-metadata.png
   :align: center
   :width: 60%
