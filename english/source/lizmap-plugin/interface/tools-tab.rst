===============================================================
Outils - Configurer les outils à afficher dans le client WEB
===============================================================
 
L'onglet Outils
===============================================================

Présentation
-------------

Cet onglet permet de configurer des outils avancés de Lizmap

.. image:: ../MEDIA/interface-tools-tab.png
   :align: center
   :width: 80%
   

Localiser par couche
===============================================================

L'idée de cet outil est de présenter à l'utilisateur de Lizmap Web Client une liste déroulante qui permet de zoomer automatiquement sur un ou plusieurs objets spatiaux de la couche. 

Cas d'utilisation
------------------

Prenons comme exemple une couche vectorielle spatiale **Communes** contenue dans le projet QGIS. On choisit d'ajouter ces communes dans l'outil *Localiser par couche*, pour permettre aux utilisateurs de Lizmap Web Client de se positionner rapidement sur une des communes. 

Une fois cette couche ajoutée dans l'outil *Localiser par couche*, une liste déroulante contenant les communes s'affiche sur l'interface web de Lizmap. Le responsable de la publication du projet Lizmap a choisi d'afficher le nom de la commune dans cette liste. Lorsque l'utilisateur de la carte web sélectionne un nom dans cette liste, la carte se recentre automatiquement sur la commune sélectionnée, et la géométrie de la commune s'affiche. L'utilisateur peut masquer la géométrie en cliquant sur un petit bouton représentant un pinceau.


Pré-requis
------------

.. note:: La ou les couches qu'on souhaite utiliser doivent être **publiée(s) comme couche WFS** : cocher la case correspondante dans l'onglet *Serveur OWS* de la partie *Capacités WFS* des propriétés du projet QGIS.

Fonctionnement
---------------

Pour ajouter une couche à cet outil:

* on choisit la couche via la première liste déroulante parmi les couches vectorielles du projet, 
* puis la colonne qui contient le libellé qu'on souhaite afficher dans la liste déroulante. 
* Si on souhaite que la géométrie liée aux objets soit aussi affichée sur la carte lorsque l'utilisateur sélectionne un élément de la liste, alors on coche l'option *Afficher la géométrie*.
* Enfin on clique sur le bouton *Ajouter la couche* pour l'ajouter dans la liste

Pour supprimer une des couches déjà configurée:

* on sélectionne la ligne en cliquant sur l'une des cases de la couche à supprimer
* on clique sur le bouton *Enlever la couche*


.. note:: Au maximum 3 couches du projet peuvent être ajoutées à l'outil Localiser par couches


.. _lizmap_annotation:

Couches d'annotation
===============================================================

Principe
----------

Lizmap permet aux utilisateurs en ligne **d'ajouter du contenu** à des couches **Spatialite ou PostGreSQL** du projet QGIS. Pour les couches d'annotations, l'utilisateur de l'application Web peut utiliser l'outil **Annotation** du menu pour numériser une géométrie et remplir les données attributaires liées. 

Le **formulaire** présenté à l'utilisateur pour renseigner la **table attributaire** prend en charge les **Outils d'éditions** proposés dans l'onglet *Champs* des *propriétés de la couche* vectorielle QGIS. On peut donc configurer une liste déroulante, masquer une colonne, la rendre non-éditable, utiliser une case à cocher, un champ texte, etc.

De plus, Lizmap Web Client détecte automatiquement le type de colonne (entier, réel, chaîne de caractère, etc.) et ajoute les vérifications et les contrôles nécessaires sur les champs.


Déroulement dans Lizmap Web Client
-----------------------------------

Voici le déroulement d'un ajout d'élément à une couche d'annotation dans l'interface Web

* L'utilisateur sélectionne la couches dans laquelle ajouter un élément via le menu *Annotation*.
* Il dessine sur la carte pour numériser l'élement à ajouter.
* Il double-clique le dernier point pour finaliser la numérisation de la géométrie.
* Un formulaire est automatiquement affiché: l'utilisateur peut remplir les données attributaires via les champs texte, les listes déroulantes, etc.
* Il valide le formulaire.
* Lizmap contrôle les champs du formulaire. Si aucun problème n'est survenu, la géométrie et les données liées sont automatiquement ajoutée dans la table correspondant à la couche dans la base de données. Sinon le formulaire est affiché et les erreurs à corriger mises en valeur.
* La carte se raffraîchit pour montrer les nouvelles données.

.. note:: On peut configurer jusqu'à 3 couches d'annotations: une par type de géométrie (point, ligne, polygone)

Exemples d'utilisation
----------------------

* **Une commune** souhaite permettre aux citoyens de recenser les problèmes visibles sur la voirie: poubelles non ramassées, lampadaires en panne, épaves à enlever. L'administrateur du projet QGIS crée une couche dédiée à ce recueil de données et affiche à tous la donnée.

* **Un bureau d'étude** souhaite permettre aux partenaires d'un projet de remonter des remarques sur des zones du projet, mais ne veut pas que les utilisateurs voient les remarques des autres. Il crée une couche de type polygone dans sa base de données PostGreSQL, qu'il met dans un groupe caché ( voir :ref:`hide_layers` ).

Configurer les annotations
---------------------------

Pour pouvoir ajouter l'outil d'annotations dans Lizmap Web Client, il faut

* *Au moins une couche vectorielle de type PostGis ou Spatialite* dans le projet QGIS
* *Configurer les outils d'éditions pour cette couche.* Ce n'est pas obligatoire mais recommandé pour contrôler les données saisies par les utilisateurs.
* *Ajouter la couche dans l'outil via le plugin*

Voici le détail des étapes:

1. Si nécessaire, **créer une couche** dans votre base de données, du type de géométrie souhaité (point, ligne, polygone, etc.)

  - pensez à ajouter une **clé primaire** : c'est indispensable
  - cette colonne de clé primaire doit être de type **"auto-incrémenté"**. Par exemple *serial* pour PostGresql.
  - pensez à ajouter un **index spatial** : c'est important pour les performances
  - *créer autant de champs dont vous avez besoin pour les attributs* : utiliser des noms de champ simples !

  Veuillez vous référer à la documentation de QGIS pour voir comment créer une couche spatiale dans une base de données PostGIS ou Spatialite: http://docs.qgis.org/html/fr/docs/user_manual/index.html
  
2. **Configurer les outils d'édition** pour les champs de votre couche

  - *Ouvrir les propriétés de la couche* en double-cliquant sur le nom de la couche dans la légende
  - Aller à l'onglet *Champs*
  - Choisir l'*Outil d'édition* via la liste déroulante pour chacun des champs de la couche

    + Pour masquer un champ, choisir *Cachée*. L'utilisateur ne verra pas ce champ dans le formulaire. Aucun contenu n'y sera écrit. *Utilisez-le pour la clé primaire*
    + Pour afficher un champ en lecture seule, choisir *Immuable*
    + etc.
    
3. **Activer l'outil d'annotation** via la case à cocher du plugin Lizmap

4. **Sélectionner la couche via une des 3 listes déroulantes du plugin**. Vous pouvez donc utiliser jusqu'à 3 couches: une de type Point, une de type Ligne, une de type Polygone
  
.. note:: Tous les outils d'édition ne sont pas encore gérés par Lizmap Web Client. Seuls les outils suivants le sont: Edition de ligne, Classification, Plage, Liste de valeurs, Immuable, Cachée, Boite à cocher, Edition de texte, Calendrier. Si l'outil n'est pas géré, le formulaire web affichera un champ texte libre.    


Réutiliser les données des couches d'annotation
------------------------------------------------

Les couches que vous avez sélectionnées pour l'outil d'annotation sont des couches comme les autres, ce qui implique:

* **Les styles et les étiquettes de QGIS s'appliquent sur ces couches.** On peut donc créer des styles qui et des étiquettes qui dépendent d'une valeur d'une des colonnes de la couche.

* Si on souhaite proposer l'outil d'annotation, mais ne pas permettre aux utilisateurs de voir les données de la couche en ligne ( et donc les ajouts des autres utilisateurs) : **on peut simplement masquer la ou les couches d'annotation** en les mettant dans un répertoire *hidden*. Voir :ref:`hide_layers`

* **Les couches sont imprimables** si elles ne sont pas masquées.

* **Les données sont enregistrées dans une couche du projet**. L'administrateur peut donc récupérer ces données et les utiliser par la suite. 

.. note:: Pour bien centraliser les choses, nous conseillons d'utiliser une base de données PostGis pour stocker les données. Pour les couches Spatialite, il faut faire attention à ne pas écraser le fichier Spatialite stocké dans le répertoire Lizmap sur le serveur par celui que vous avez en local: pensez à toujours faire une sauvegarde du fichier du serveur avant une nouvelle synchronisation de votre répertoire local.

Utilisation du cache
----------------------

.. note:: Si vous souhaitez utiliser le cache serveur ou client pour les couches d'annotation, faites-le en toute connaissance de cause : les données ne seront pas visibles par les utilisateurs tant que le cache ne sera pas expiré. Nous conseillons de ne pas activer le cache pour les couches d'annotation


