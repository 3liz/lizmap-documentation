===============================================================
Outils - Configurer les outils à afficher dans le client WEB
===============================================================

L'onglet Outils
===============================================================

Présentation
-------------

Cet onglet permet de configurer des outils avancés de Lizmap :

* **Localiser par couche**
* **Édition de couches**
* **Filtrer les données par utilisateur**
* **Time manager**


.. _locate_by_layer:

Localiser par couche
===============================================================

.. image:: ../MEDIA/interface-tools-tab-locate.png
   :align: center
   :width: 80%

L'idée de cet outil est de présenter à l'utilisateur de Lizmap Web Client une liste déroulante qui permet de zoomer automatiquement sur un ou plusieurs objets spatiaux de la couche.

Cas d'utilisation
------------------

Prenons comme exemple une couche vectorielle spatiale **Quartiers** contenue dans le projet QGIS. On choisit d'ajouter ces quartiers dans l'outil *Localiser par couche*, pour permettre aux utilisateurs de Lizmap Web Client de se positionner rapidement sur un des quartiers.

Une fois cette couche ajoutée dans l'outil *Localiser par couche*, une liste déroulante contenant les quartiers s'affiche sur l'interface web de Lizmap.

Lorsque l'utilisateur de la carte web sélectionne un nom dans cette liste, la carte se recentre automatiquement sur le quartier sélectionné, et la géométrie du quartier s'affiche (en option).


Pré-requis
------------

.. note:: La ou les couches qu'on souhaite utiliser doivent être **publiée(s) comme couche WFS** : cocher la case correspondante dans l'onglet *Serveur OWS* de la partie *Capacités WFS* des propriétés du projet QGIS.

Fonctionnement
---------------

Pour ajouter une couche à cet outil:

* on **choisit la couche** via la première liste déroulante parmi les couches vectorielles du projet,
* puis **la colonne qui contient le libellé** qu'on souhaite afficher dans la liste déroulante.
* Si on souhaite que **la géométrie** liée aux objets soit aussi affichée sur la carte lorsque l'utilisateur sélectionne un élément de la liste, alors on coche l'option *Afficher la géométrie*.
* Enfin on clique sur le bouton **Ajouter la couche** pour l'ajouter dans la liste

Pour supprimer une des couches déjà configurée:

* on sélectionne la ligne en cliquant sur l'une des cases de la couche à supprimer
* on clique sur le bouton **Enlever la couche**

Listes hiérarchiques
-----------------------

Si on reprend l'exemple des quartiers, il peut être intéressant de proposer aussi à l'utilisateur une liste déroulante des *sous-quartiers*. On souhaite que lorsque l'utilisateur choisit un quartier, alors la liste déroulante des sous-quartiers soit automatiquement filtrée pour n'afficher que les sous-quartiers du quartier choisi.

Pour cela, il existe 2 méthodes :

* soit on a **2 couches vectorielles distinctes** : une pour les quartiers, et une pour les sous-quartiers. Alors il faut utiliser une **jointure attributaire** entre les 2 couches pour activer le filtrage automatique des listes dans Lizmap.
* soit on n'a qu'**1 seule couche des sous-quartiers**, et alors on peut spécifier via le plugin l'**attribut de regroupement**. Deux listes déroulantes seront créées au lieu d'une seule dans l'application Web.


.. note:: Au maximum 3 couches du projet peuvent être ajoutées à l'outil Localiser par couches


.. _lizmap_edition:

Édition de couches
===============================================================

Cette fonctionnalité offre la possibilité aux utilisateurs en ligne d'éditer des données spatiales pour des couches PostGIS ou Spatialite. Voir :ref:`edition_in_lizmap` pour le détail de cette fonctionnalité.


Couches filtrées - Filtrer les données en fonction des utilisateurs
====================================================================

Ce tableau permet de configuré les couches dont le contenu sera filtré sur l'interface Web en fonction de l'utilisateur connecté. Voir :ref:`filter_layer_data_by_group`


Time Manager - Animer des couches vectorielles temporelles
============================================================

Dans l'application *Lizmap Web Client*, il est possible de lancer des animation sur des données vectorielles temporelles. Voir :ref:`time_manager`
