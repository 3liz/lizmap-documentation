.. _filter_layer_data_by_group:

===================================================================
Couches filtrées - Filtrer les données en fonction des utilisateurs
===================================================================

Présentation de la fonctionnalité
===============================================================

Habituellement, la gestion des droits d'accès aux projets Lizmap se fait par répertoire. La configuration se fait dans ce cas via l'interface d'administration de Lizmap Web Client. Voir :ref:`hide_layers`. Cela permet de masquer complètement certains projets en fonction des groupes d'utilisateurs, mais oblige une gestion par répertoire et projet.

Au contraire, la fonctionnalité de filtrage présentée ici permet de publier un seul projet QGIS, et de filtrer les données affichées sur la carte en fonction de l'utilisateur connecté. Il est possible de filtrer uniquement les couches vectorielles, car Lizmap se base sur une colonne de la table attributaire.

Le filtrage se base sur l'identifiant du groupe de l'utilisateur actuellement connecté à l'application Web. Il est actif pour toutes les requêtes vers le serveur QGIS, et concerne donc :

* les images des couches vectorielles affichées sur la carte
* les popups
* les listes de la fonction *Localiser par couche*. Voir :ref:`locate_by_layer`
* les listes déroulantes des *formulaires d'édition* issues de *Valeur relationnelle*. Voir :ref:`edition_in_lizmap`
* les fonctionnalités à venir (affichage de la table attributaire, fonctions de recherche, etc.)

Un tutoriel vidéo est disponible à cette adresse : https://vimeo.com/83966790


Configurer l'outil de filtrage des données
===========================================

Pour utiliser l'outil de filtrage des données dans *Lizmap Web Client*, il faut

* utiliser **QGIS 2** sur le serveur
* avoir **accès à l'interface d'administration** de Lizmap

Voici le détail des étapes pour configurer cette fonctionnalité:

1. **Connaître les identifiants des groupes d'utilisateurs** configurés dans l'interface d'administration de Lizmap Web Client. Pour cela, il faut aller dans l'interface d'administration, menu *SYSTÈME > Groupes d'utilisateurs* : l'identifiant apparaît entre parenthèse derrière le nom de chaque groupe (sous le titre "Groupes des nouveaux utilisateurs")

2. Pour toutes les couches vectorielles dont on souhaite filtrer les données, il suffit d'**ajouter une colonne textuelle qui contiendra pour chaque ligne l'identifiant du groupe (et pas le nom !!) qui a le droit de visualiser cette ligne**.

  - *Remplir cette colonne* pour chaque ligne de la table attributaire avec l'identifiant du groupe qui a le droit de voir la ligne (via la calculatrice par exemple)
  - Il est possible de mettre **all** comme valeur dans certaines lignes pour désactiver le filtre : tous les utilisateurs verront les données de ces lignes.
  - Si la valeur contenue dans cette colonne pour une ligne ne correspond pas à un des groupes d'utilisateurs, alors la donnée ne sera affichée pour aucun utilisateur

3. Ajouter la couche dans le tableau **Filtrer les données par utilisateur** situé dans l'onglet *Outils* du plugin Lizmap:

  - *Sélectionner la couche* dans la liste déroulante
  - Sélectionner le champ qui contient l'*identifiant du groupe* pour la couche
  - Ajouter la couche dans la liste via le bouton *Ajouter la couche*
  - Pour enlever une couche du tableau, cliquer dessus et cliquer sur le bouton *Enlever la couche*

4. **Désactiver le cache client ET le cache Serveur** pour toutes les couches filtrées. Sinon, les données affichées ne seront pas mises à jour entre chaque connexion ou déconnexion d'utilisateur !


Débrider le filtrage pour certains groupes d'utilisateurs
==========================================================

Dans l'interface d'administration de Lizmap Web Client, il est possible de décider qu'un ou plusieurs groupes d'utilisateur pourra **toujours voir toutes les données des couches filtrées**. Le filtrage sera donc désactivé pour ce ou ces groupes.

Pour cela, il faut modifier les *propriétés du répertoire Lizmap* qui contient les projets avec des couches filtrées, et cocher le droit **Afficher toutes les données, mêmes si filtrées par login** pour le ou les groupes désirés. Alors les utilisateurs de ces groupes verront toujours toutes les données.

Voir :ref:`define_group_rights`
