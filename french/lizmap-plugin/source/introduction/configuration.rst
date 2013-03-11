===============================================================
Configurer un projet QGIS pour Lizmap
===============================================================

Créer un projet QGIS vierge
===============================================================

Ouvrir le logiciel QGIS, puis créer un projet vierge

* C'est simple, *il suffit d'enregistrer*
* Enregistrer le projet dans votre répertoire de travail
* 1ère étape avant toute chose : *configurer le projet*

 * Menu *Préférences > Propriétés du projet* OU CTRL+MAJ+P
 * Vérifier que le projet est bien en relatif


Configuration des propriétés du projet
===============================================================


Système de Coordonnées de Référence
----------------------------------------------------

.. ../MEDIA/introduction-projet-scr.png
   :align: center
   :width: 90%

A faire

* Définir le SCR du projet : par exemple le CC43
* Activer *la reprojection à la volée*. QGIS sait reprojeter les raster et les vecteurs


Serveur OWS
-------------------------------------------------------

.. ../MEDIA/introduction-projet-ows.png
   :align: center
   :width: 90%

A faire

* Remplir les métadonnées textuelles: titre, 
* Configurer l'emprise de la carte : 

 * il faudra y revenir une fois qu'on aura ajouter les couches

* Ajouter des restrictions de projections si besoin pour les fonds externes


Ajouter des couches vecteur et raster au projet
===============================================================

Plusieurs méthodes :

* Par le menu : *Couche > Ajouter une couche...*
* Par la fenêtre *Parcourir*
* Par glisser/déposer depuis l'explorateur de fichiers
* En ouvrant un fichier depuis l'explorateur

Info
  La fenêtre parcourir offre un accès immédiat et permet d'ouvrir plusieurs couches en une seule fois.


Organiser et manipuler les couches dans la légende
===============================================================

* Les *groupes* : un clic droit dans la zone blanche de la légende: *Ajouter un nouveau groupe*
* On peut *déplacer* les couches et les groupes via *glisser-déplacer*, renommer avec F2
* *Ordre de rendu* - 2 modes proposés

  - *l'ordre de la légende* : les couches du dessus sont rendues au dessus des autres.
  - en spécifiant *un ordre des couches* : Menu *Vue > Panneaux > Ordre des couches*

*Lizmap sait gérer les 2 types de rendu*


.. ../MEDIA/introduction-projet-qgis-legend.png
   :align: center
   :width: 90%
   



