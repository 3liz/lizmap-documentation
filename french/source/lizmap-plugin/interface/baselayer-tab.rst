========================================================
Fonds - configurer les fonds cartographiques
========================================================

Principe
==========

Il est souvent intéressant de séparer dans une carte publiée sur internet les couches de fonds référentiels et les couches thématiques. Dans Lizmap, on peut utiliser des groupes ou des couches du projet comme fond référentiel. Ces couches seront présentées à part des autres couches, dans une fenêtre *Fonds de carte*. La configuration se fait via l'*onglet Carte*. Voir :ref:`layers_tab`

En plus de cette possibilité, l'administrateur du projet QGIS peut aussi :

* ajouter des fonds externes (OpenStreetMap, Google, IGN, Bing)
* ajouter des couches provenant d'autres projets Lizmap


.. note:: Si une seule couche de fond est configurée (couche du projet, couche web externe ou couche d'un autre projet Lizmap), alors l'interface Lizmap Web Client ne montrera pas la boîte *Fonds de carte*, mais la couche sera néanmoins visible sous les autres couches.

Fonds externes
=====================

Lizmap permet d'ajouter des fonds externes à la liste des fonds de carte. Ces fonds proviennent des services WEB de plusieurs prestataires :

* **OpenStreetMap** : fond officiel, fond Mapquest, fond cyclable (OpenCycleMap)
* **Google** : Rues, Satellite, Hybride, Relief
* **Bing Map** : Rues, Satellite, Hybride
* **IGN** (Institut National de l'Information Géographique et Forestière) : Plan, Orthophotos, Scans

.. image:: ../MEDIA/interface-baselayers-tab-external.png
   :align: center
   :width: 80%

Pour certains des fonds, vous devez donner votre **clé d'identification** pour pouvoir visualiser les couches dans l'application web.

L'ajout d'un ou de plusieurs fond(s) externe(s) à votre carte Lizmap a plusieurs conséquences, qu'il faut bien connaître pour anticiper le rendu :

* **c'est ce fond externe qui imposera les échelles de la carte**. Les échelles configurées dans l'onglet Carte ne seront donc pas utilisées, sauf les échelles min et max pour restreindre la carte entre ces 2 échelles.

  Il faut donc faire attention dans le projet QGIS à adapter les seuils de visibilités des couches en fonction des échelles du fond externe. Voici les échelles entières approximatives des fonds externes courants::

    0   591659008
    1   295829504
    2   147914752
    3   73957376
    4   36978688
    5   18489344
    6   9244672
    7   4622336
    8   2311168
    9   1155584
    10  577792
    11  288896
    12  144448
    13  72224
    14  36112
    15  18056
    16  9028
    17  4514
    18  2257


* L'affichage des données du projet QGIS se faisant sur un fond externe, **QGIS doit donc reprojeter à la volée les données dans le système spatial de référence du fond** Il faut donc ajouter cette projection dans l'onglet OWS des propriétés du projet. Pour l'instant, l'ensemble des fonds proposés utilise la projection::

    EPSG:3857 ; Pseudo Mercator

* **Les fonds externes ne peuvent pas être imprimés par QGIS**

  En effet, ils ne sont pas dans le projet QGIS, et sont ajoutés dynamiquement par Lizmap Web Client. Ils ne sont donc pas accessibles aux composeurs de QGIS

* **Respecter la licence des données et les conditions d'utilisation**

  + *Google*: https://developers.google.com/maps/terms
  + *OpenStreetMap*: http://wiki.openstreetmap.org/wiki/FR:Tile_usage_policy
  + *Mapquest*: http://developer.mapquest.com/web/products/open/map#terms
  + *IGN*: http://api.ign.fr/services#web
  + *Bing*: https://www.microsoft.com/maps/product/terms.html


.. _lizmap_external_baselayers:

Couches Lizmap externes
========================

Cette fonctionnalité a été supprimée. Elle est remplacée par la possibilité d'utiliser le menu  **Couches > Intégrer des couches et des groupess**, et de déclarer dans l'onglet *Couches* du plugin le projet parent et le répertoire Lizmap pour ces couches ou groupes intégrés. Voir :ref:`layers_tab_embedded:`
