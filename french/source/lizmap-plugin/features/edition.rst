.. _edition_in_lizmap:

===============================================================
L'édition de données dans Lizmap
===============================================================

Principe
===============================================================

Depuis la version 2.8, il est possible de permettre aux utilisateurs d'**éditer des données spatiales et attributaires** depuis l'interface Lizmap Web Client, pour les couches **Spatialite ou PostGreSQL** du projet QGIS. Le plugin Lizmap permet d'ajouter une ou plusieurs couches et de choisir pour chacune quelles actions seront possible dans l'interface web:

* création d'élements
* modification des attributs
* modification de la géométrie
* suppresion d'éléments

Le **formulaire web** présenté à l'utilisateur pour renseigner la **table attributaire** prend en charge les **Outils d'éditions** proposés dans l'onglet *Champs* des *propriétés de la couche* vectorielle QGIS. On peut donc configurer une liste déroulante, masquer une colonne, la rendre non-éditable, utiliser une case à cocher, un champ texte, etc. Toute la configuration se fait à la souris, dans QGIS et dans le plugin Lizmap.

De plus, Lizmap Web Client détecte automatiquement le type de colonne (entier, réel, chaîne de caractère, etc.) et ajoute les vérifications et les contrôles nécessaires sur les champs.


Déroulement dans Lizmap Web Client
====================================

Voici par exemple le déroulement d'un ajout d'élément à une couche d'édition dans l'interface Web

* L'utilisateur sélectionne la couches dans laquelle ajouter un élément via le menu **Edition**.
* En fonction des *actions configurées* pour la couche choisie, des **boutons d'action** sont affichés dans le panneau d'édition qui s'ouvre au dessus de la légende.
* Pour ajouter un nouvel élément à la couche d'édition, l'utlisateur clique sur le bouton *Ajouter*
* Il dessine sur la carte pour numériser l'élement à ajouter.
* Il double-clique le dernier point pour **finaliser la numérisation** de la géométrie.
* Un **formulaire** est automatiquement affiché: l'utilisateur peut remplir les données attributaires via les champs texte, les listes déroulantes, etc.. Le formulaire a été configuré dans QGIS.
* Il valide le formulaire.
* Lizmap Web Client **contrôle la validité des données** entrées dans les champs du formulaire. Si aucun problème n'est survenu, la géométrie et les données liées sont automatiquement ajoutée dans la table correspondant à la couche dans la base de données. Sinon le formulaire est affiché et les erreurs à corriger mises en valeur.
* La carte se raffraîchit pour montrer les nouvelles données.

Pour les couches d'édition dont la modification de géométrie ou d'attributs a été configurée, un bouton **Sélectionner** est présenté à l'utilisateur lorsqu'il sélectionne la couche via le menu Edition.

* Une fois ce bouton cliqué, l'utilisateur doit cliquer sur la carte pour sélectionner un élément de la couche.
* Un panneau s'ouvre et liste les éléments positionnés sous le clic de l'utilisateur.
* L'utilisateur sélectionne l'un des éléments de la liste via le bouton **Sélectionner**
* Il peut ensuite modifier la géométrie si cette possibilité a été configurée dans le plugin Lizmap.
* Ensuite il clique sur le bouton **Valider** , ce qui ouvre le formulaire d'édition des attributs.
* Une fois le formulaire validé, les modifications sont enregistrées dans la couche.

.. note:: On peut configurer jusqu'à 5 couches d'édition.

Exemples d'utilisation
=======================

* **Une commune** souhaite permettre aux citoyens de recenser les problèmes visibles sur la voirie: poubelles non ramassées, lampadaires en panne, épaves à enlever. L'administrateur du projet QGIS crée une couche dédiée à ce recueil de données et affiche à tous la donnée.

* **Un bureau d'étude** souhaite permettre aux partenaires d'un projet de remonter des remarques sur des zones du projet. Il permet l'ajout de polygones dans une couche dédiée.


Configurer l'outil d'édition
==============================

Pour permettre l'édition de données dans *Lizmap Web Client*, il faut

* **Au moins une couche vectorielle de type PostGis ou Spatialite** dans le projet QGIS
* **Configurer les outils d'éditions pour cette couche** dans l'onglet *Champs* des propriétés de la couche. Ce n'est pas obligatoire mais recommandé pour contrôler les données saisies par les utilisateurs.
* **Ajouter la couche dans l'outil via le plugin**

Voici le détail des étapes:

1. Si nécessaire, **créer une couche** dans votre base de données, du type de géométrie souhaité (point, ligne, polygone, etc.)

  - pensez à ajouter une **clé primaire** : c'est indispensable !
  - cette colonne de clé primaire doit être de type **"auto-incrémenté"**. Par exemple *serial* pour PostGresql.
  - pensez à ajouter un **index spatial** : c'est important pour les performances
  - *créer autant de champs dont vous avez besoin pour les attributs* : utiliser si possible des noms de champ simples !

  Veuillez vous référer à la documentation de QGIS pour voir comment créer une couche spatiale dans une base de données PostGIS ou Spatialite: http://docs.qgis.org/html/fr/docs/user_manual/index.html
  
2. **Configurer les outils d'édition** pour les champs de votre couche

  - *Ouvrir les propriétés de la couche* en double-cliquant sur le nom de la couche dans la légende
  - Aller à l'onglet *Champs*
  - Choisir l'*Outil d'édition* via la liste déroulante pour chacun des champs de la couche

    + Pour masquer un champ, choisir *Cachée*. L'utilisateur ne verra pas ce champ dans le formulaire. Aucun contenu n'y sera écrit. *Utilisez-le pour la clé primaire*
    + Pour afficher un champ en lecture seule, choisir *Immuable*
    + Cas particulier de l'option *Valeur relationnelle*. Vous pouvez utiliser cette option pour une carte Lizmap. Pour que les utilisateurs aient accès aux informations de la couche externe qui contient les données, il faut activer la publication de la couche en WFS dans l'onglet *Serveur OWS* de la boîte de dialogue *Propriétés du projet* dans QGIS.
    + etc.

.. note:: Tous les outils d'édition ne sont pas encore gérés par Lizmap Web Client. Seuls les outils suivants le sont: Edition de ligne, Classification, Plage, Liste de valeurs, Immuable, Cachée, Boite à cocher, Edition de texte, Calendrier, Valeur relationnelle. Si l'outil n'est pas gérée, le formulaire web affichera un champ texte libre.    

4. Ajouter la couche dans le tableau **Édition de couches** situé dans l'onglet *Outils* du plugin Lizmap:

  - *Sélectionner la couche* dans la liste déroulante
  - Cocher les actions que vous souhaitez activer parmi: *Créer, Modifier les attributs, Modifier la géométrie, Supprimer*
  - Ajouter la couche dans la liste via le bouton *Ajouter la couche*

.. image:: ../MEDIA/features-edition-table.png
   :align: center
   :width: 80%
  



Réutiliser les données des couches d'édition
================================================

Les couches que vous avez sélectionnées pour l'outil d'édition sont des **couches comme les autres**, ce qui implique:

* **Les styles et les étiquettes de QGIS s'appliquent sur ces couches.** On peut donc créer des styles qui et des étiquettes qui dépendent d'une valeur d'une des colonnes de la couche.

* Si on souhaite proposer l'outil d'édition, mais ne pas permettre aux utilisateurs de voir les données de la couche en ligne ( et donc les ajouts des autres utilisateurs) : **on peut simplement masquer la ou les couches d'édition** en les mettant dans un répertoire *hidden*. Voir :ref:`hide_layers`

* **Les couches sont imprimables** si elles ne sont pas masquées.

* **Les données sont enregistrées dans une couche du projet**. L'administrateur peut donc récupérer ces données et les utiliser par la suite. 

.. note:: Pour bien centraliser les choses, nous conseillons d'utiliser une base de données PostGis pour stocker les données. Pour les couches Spatialite, il faut faire attention à ne pas écraser le fichier Spatialite stocké dans le répertoire Lizmap sur le serveur par celui que vous avez en local: pensez à toujours faire une sauvegarde du fichier du serveur avant une nouvelle synchronisation de votre répertoire local.

Utilisation du cache
=====================

.. note:: Si vous souhaitez utiliser le cache serveur ou client pour les couches d'édition, faites-le en toute connaissance de cause : les données ne seront pas visibles par les utilisateurs tant que le cache ne sera pas expiré. Nous conseillons de ne pas activer le cache pour les couches d'édition

