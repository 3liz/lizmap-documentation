===============================================================
Les bonnes pratiques
===============================================================

Lizmap : la notion de "répertoire"
===============================================================

Lizmap Web Client peut utiliser les cartes QGIS enregistrées dans différents répertoires sur le serveur.

* Un *répertoire Lizmap* est un dossier sur le serveur où sont stockés un ou plusieurs projet QGIS et les données liées.
* On peut utiliser les répertoires pour *regrouper des projets liés par une thématique*
* On peut utiliser les répertoires pour *gérer les droits d'accès sur les cartes*


Les répertoires dans Lizmap
===============================================================

* **répertoire du projet QGIS** : **pas d'espace ni accents**

 * un ou plusieurs projets QGIS
 * un répertoire *donnees*

  * *rasters* contient tous les fichiers raster : MNT, photo aériennes, etc.
  * *vecteurs* contient les vecteurs : shapefile, KML, GPX, CSV, excel, etc.
  * *images* contient les images SVG utilisées dans les styles
  * *media* contient les documents qu'on souhaite utiliser dans Lizmap
  * *cartes* contient les cartes produites avec QGIS

Les données vectorielles
===============================================================

Quelques bonnes pratiques:

* *Noms des couches*

 - jamais d'accents dans les noms des couches
 - jamais de caractères spéciaux
 - pas 2 fois le même nom pour une couche ou un groupe

* *Nom des colonnes*

 - pas d'accents ni caractères spéciaux
 - des noms courts et simples
 
* *Encodage* : connaître l'encodage des couches et toujours utiliser le même


Configuration des propriétés du projet
===============================================================

Général
----------------------------------------------------

Menu *Préférences > Propriétés du projet* OU CTRL+MAJ+P

* *Couleur de la sélection* : laisser jaune
* *Couleur de fond d'écran* : laisser blanc, c'est standard
* *Enregistrer les chemins* : Toujours travailler en relatif !

Info
  Cela permet de copier/coller un projet et des données dans un autre répertoire ou un autre ordinateur.
Lizmap
  *C'est indispensable pour que la carte fonctionne sur le serveur Lizmap*


Système de Coordonnées de Référence
----------------------------------------------------

SCR = *Système de coordonnées de références*

* Il faut toujours définir un SCR pour un projet QGIS
* Utiliser au maximum *les projections IGN RGF93*. Dans l'Hérault = CC43.
* Voir le PDF Supports/Documentation/RGF93_theorie_et_concept_T3.pdf
* Toujours activer *la reprojection à la volée*. QGIS sait reprojeter les raster et les vecteurs

Aide
  Pour choisir un SCR, il suffit de taper son code ou des premières lettres dans le champ texte du dessus, puis de cliquer dans la liste filtrée.


Serveur OWS
-------------------------------------------------------

Utilisé par QGIS Server : il permet de configurer comment les couches seront publiées en WMS et WFS.

Il faut toujours:

* Remplir les métadonnées textuelles
* Configurer l'emprise de la carte
* Ajouter des restrictions de projections si besoin (fonds externes)
