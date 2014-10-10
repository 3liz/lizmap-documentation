===============================================================
Guide utilisateur
===============================================================

La page projets
===============================================================

Par défaut Lizmap propose une page présentant une liste de cartes organisées par répertoire.

.. image:: MEDIA/user-guide-01-projects.png
   :align: center
   :scale: 80%

Il est possible de consulter directement la fiche d'information d'une carte. Ces informations proviennent directement du projet QGIS.

.. image:: MEDIA/user-guide-02-information.png
   :align: center
   :scale: 80%

L'accès au carte se fait soit en cliquant sur une des botons **Accéder à la carte** ou sur l'image qui accompagne le projet.

Une carte simple
===============================================================

LizMap propose par défaut des cartes web ayant les fonctionnalités suivantes :

* déplacement
* zoom sur une zone dessinée par l'utilisateur
* zoom avant
* sélection d'un niveau de zoom via une barre de niveau
* zoom arrière
* affichage de l'échelle sous forme d'une barre et de façon numérique

L'ordre et l'organisation des couches dans le panneau de gestion des couches respectent ceux définies dans QGIS par l'éditeur de la carte.

.. image:: MEDIA/user-guide-03-simple-map.png
   :align: center
   :scale: 80%

Les fonctions de zoom et de déplacement sont disponible sur la droite de la carte. Pour zoomer sur une zone, vous devez sélectionner la fonction de *zoom par rectangle* puis cliquer-déplacer pour dessiner un rectangle définissant la zone à atteindre.

.. image:: MEDIA/user-guide-03-simple-map-zoom.png
   :align: center
   :scale: 80%

Vous pouvez à l'aide des *triangle*, à gauche du titre des couches, faire apparaître la légende de la couche.

.. image:: MEDIA/user-guide-04-legend.png
   :align: center
   :scale: 80%

Les boîtes de sélection vous permettent de cacher et d'afficher les couches proposées.

.. image:: MEDIA/user-guide-05-show-hide-layer.png
   :align: center
   :scale: 80%

Afin de profiter pleinement de la carte, vous avez la possibilité de cacher le panneau de gestion des couches.

.. image:: MEDIA/user-guide-06-hide-layer-switcher.png
   :align: center
   :scale: 80%

Enfin vous pouvez :

* revenir à la page des projets
* afficher la fiche d'information de la carte

L'authentification
===============================================================

L'administrateur peut restreindre l'accès à certains groupes de carte. Pour accéder à ces cartes, il vous faut vous authentifier. L'authentification est accessible grâce au bouton *Connexion* en haut à gauche.

.. image:: MEDIA/user-guide-07-authentication.png
   :align: center
   :scale: 80%

Une fois l'authentification validée, en fonction de vos droits, vous devriez avoir accès à de nouvelles cartes.

.. image:: MEDIA/user-guide-07-authentication-projects.png
   :align: center
   :scale: 80%

Vous pouvez vous déconnecter et modifier vos informations d'utilisateurs.

Les fonctionnalités avancées
===============================================================

L'éditeur de la carte peut ajouter certaines fonctionnalités en fonction de l'expérience utilisateur souhaitée :

* sélection d'un fond de plan
* localisation par couche
* mesures de distance, surface et périmètre
* impression de la carte
* édition de données

.. image:: MEDIA/user-guide-07-advanced-features.png
   :align: center
   :scale: 80%

La sélection d'un fond de plan
-------------------------------

A l'aide du plugin LizMap, l'éditeur peut avoir ajouter à la carte des fonds de plan externe ou un fond de plan vide. Ces fonds de plan sont accessibles dans le panneau de gestion des couches sous forme d'une liste.

.. image:: MEDIA/user-guide-08-baselayers.png
   :align: center
   :scale: 80%



La localisation par couche
---------------------------

Cette fonction est affiché par défaut si elle a été activé par l'éditeur de la carte.

Elle se trouve au dessus du panneau de gestion des couches et se présentent sous forme de liste. Certaines listes nécessitent de saisir quelques caractères avant de proposer des localisations.

.. image:: MEDIA/user-guide-09-locate-by-layer.png
   :align: center
   :scale: 80%


Il suffit de sélectionner dans la liste une localisation pour zoomer sur l'élément en question.

.. image:: MEDIA/user-guide-09-locate-by-layer-zoom.png
   :align: center
   :scale: 80%


La mesure
----------

La fonction de mesure permet de calculer :

* une distance
* une surface
* un périmètre

Elle est accessible dans la barre de menu de Lizmap.

.. image:: MEDIA/user-guide-10-measure-menu.png
   :align: center
   :scale: 80%

L'outil s'active en sélectionnant le type de mesure. Une fois activée, un message vous indique la marche à suivre.

.. image:: MEDIA/user-guide-11-measure-activated.png
   :align: center
   :scale: 80%

La mesure s'affiche dans la barre de message.

.. image:: MEDIA/user-guide-12-measure-value.png
   :align: center
   :scale: 80%

En double-cliquant sur la carte, la mesure se fixe. Pour recommencer vous pouvez cliquer sur la carte et ainsi relancer le calcul de la mesure.

Le bouton de droite de la barre de fonction permet d'arrêter l'utilisation de la fonctionnalité.

.. image:: MEDIA/user-guide-13-measure-stop.png
   :align: center
   :scale: 80%

Il est aussi possible de changer de fonctionnalité de mesure sans avoir à arrêter la fonction en cours.


L'impression
------------

la fonction d'impression est accessible dans la barre de menu de Lizmap. Elle dépend du nombre de composition d'impression publier par l'éditeur de la carte.

.. image:: MEDIA/user-guide-14-print-menu.png
   :align: center
   :scale: 80%

Une fois la fonctionnalité activée, une zone d'impression de la forme de celle de la composition apparait en sur impression de la carte. Cette zone permet de définir la zone à imprimer. Vous pouvez la déplacer.

.. image:: MEDIA/user-guide-15-print-zone.png
   :align: center
   :scale: 80%

Sur la gauche, au dessus du panneau de gestion des couches, vous pouvez sélectionner l'échelle de l'impression.

.. image:: MEDIA/user-guide-16-print-scale.png
   :align: center
   :scale: 80%

En fonction de la configuration de la composition d'impression, vous pouvez avoir la possibilité de saisir votre propre texte.

.. image:: MEDIA/user-guide-17-print-input.png
   :align: center
   :scale: 80%

Pour lancer la génération de l'impression, vous pouvez cliquer sur *Imprimer*. Vous obtiendrez un fichier PDF dont la mise en page aura été défini par l'éditeur de la carte.

.. image:: MEDIA/user-guide-18-print-result.png
   :align: center
   :scale: 80%


L'édition de données géographiques
-----------------------------------

L'éditeur de la carte peut permettre à des utilisateurs l'édition de certaines données. Il a aussi la possibilité de limité les modifications possibles :

* ajout d'objet
* modification géométrique
* modification d'attributs
* suppression d'objet

La fonction est accessible dans la barre de menu de Lizmap. Le menu d'édition, vous permet de sélectionner les données que vous souhaitez modifier.

.. image:: MEDIA/user-guide-19-edition-menu.png
   :align: center
   :scale: 80%

Une fois la couche sélectionné, le menu d'édition apparait. Celui-ci varie en fonction de la configuration souhaité par l'éditeur de la carte. Si toutes les modifications sont accessibles vous devez choisir entre *ajouter* un nouvelle objet ou en *sélectionner* un.

.. image:: MEDIA/user-guide-20-edition-add.png
   :align: center
   :scale: 80%

Si vous avez sélectionner *ajouter*, vous serez inviter un dessin une forme simple qui dépende de la couche de données sélectionnée :

* point
* ligne
* polygon

Dans le cas de la ligne et du polygone, vous devrez cliquer plusieurs fois afin de dessiner la forme voulu.

.. image:: MEDIA/user-guide-21-edition-add-draw.png
   :align: center
   :scale: 80%

Pour finir votre ligne ou votre polygone vous devez ajouter le dernier point en double-cliquant à l'endroit voulu. Une fois la saisie finie, un formulaire de saisie des attributs de l'objet s'affichera.

.. image:: MEDIA/user-guide-22-edition-add-attributes.png
   :align: center
   :scale: 80%

Si vous souhaitez recommencer la saisie de la forme géométrique, vous devez cliquer sur *Annuler*.

Si la forme vous convient et que vous avez saisie les informations demandées, vous pouvez *Enregistrer*. Le nouvel objet sera ajouté. Vous pourrez le modifier en le sélectionnant.

Pour sélectionner un objet à modifier, vous pouvez cliquer sur le bouton *Sélectionner*.

.. image:: MEDIA/user-guide-23-edition-select.png
   :align: center
   :scale: 80%

Une fois l'outil de sélection activé, vous devez cliquer sur la carte afin d'identifier l'objet que vous souhaitez éditer.

.. image:: MEDIA/user-guide-24-edition-select-click.png
   :align: center
   :scale: 80%

La liste des objets éditables en dessous de l'endroit du clique apparaîtra. Vous pourrez ainsi sélectionner exactement l'objet à modifier.

.. image:: MEDIA/user-guide-25-edition-select-list.png
   :align: center
   :scale: 80%

L'objet sélectionné apparait sur la carte et est directement modifiable.

.. image:: MEDIA/user-guide-26-edition-select-draw.png
   :align: center
   :scale: 80%

Vous pouvez annuler les modifications de la géométrie à l'aide du bouton "Défaire".

.. image:: MEDIA/user-guide-27-edition-select-draw-undo.png
   :align: center
   :scale: 80%

Pour valider vos modifications de dessin ou simplement accéder à la modification des attributs, vous devez cliquer sur *Modifier*.

.. image:: MEDIA/user-guide-28-edition-select-draw-validate.png
   :align: center
   :scale: 80%

Un boîte de dialogue contenant le formulaire de saisie des attributs de l'objet s'affiche alors.

.. image:: MEDIA/user-guide-29-edition-select-draw-form.png
   :align: center
   :scale: 80%

Le bouton *Valider* permet d'enregistrer les modifications de géométrie et d'attributs.

Si vous souhaitez supprimer l'objet que vous avez sélectionner, vous devez cliquer sur *Sup*.

Enfin pour désactiver l'outil édition, il vous suffit de cliquer sur *Arrêter*.

.. image:: MEDIA/user-guide-30-edition-stop.png
   :align: center
   :scale: 80%


