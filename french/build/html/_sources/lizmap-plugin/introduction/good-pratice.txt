===============================================================
Les bonnes pratiques
===============================================================

Rappel - la notion de "répertoire" dans Lizmap
===============================================================

Lizmap Web Client peut utiliser les cartes QGIS enregistrées dans différents répertoires sur le serveur.

* Un **répertoire Lizmap** est un dossier sur le serveur où sont stockés un ou plusieurs projet QGIS et les données liées.
* On peut utiliser les répertoires pour **regrouper des projets liés par une thématique**
* On peut utiliser les répertoires pour **gérer les droits d'accès sur les cartes**


Les répertoires Lizmap
===============================================================

Nous conseillons d'organiser un répertoire Lizmap toujours de la même manière, par exemple, dans notre répertoire **mon_repertoire**, il est conseillé d'avoir:

* un ou plusieurs **projets QGIS** (.qgs) et les fichiers de configuration Lizmap créés avec le plugin  (.qgs.cfg)
* un répertoire contenant les données, par exemple nommé **data**, qui peut contenir des sous-répertoires

 - *raster* contient tous les fichiers raster : MNT, photo aériennes, etc.
 - *vector* contient les vecteurs : shapefile, KML, GPX, CSV, excel, etc.
  
* un répertoire **svg** qui contient par exemple les fichiers SVG utilisés pour les styles des couches
* un répertoire **media** qui contient les documents qu'on souhaite utiliser dans Lizmap : pdf, images, fichiers textes, etc.

.. note:: Il est conseilé de ne pas utiliser d'espace ni accents dans le chemin. Par exemple : "C:\\un\\chemin\\vers\\le\\repertoire\\mon_repertoire\\"


Le répertoire de données **data** peut être placé au même niveau que les répertoires Lizmap. On peut donc avoir par exemple dans "C:\\un\\chemin\\vers\\le\\repertoire\\lizmap\\"
  
  * *mon_repertoire_1* : un répertoire Lizmap, c'est-à-dire le dossier contenant les projets, les images et les médias
  * *mon_repertoire_2* : un autre répertoire Lizmap, contenant d'autres projets QGIS
  * *data* : un dossier qui contient les fichiers de données spatiaux, par exemple organisés en 2 sous-répertoires *vector* et *raster*
  
Cela permet de partager des données, comme par exemple des orthophoto lourdes, dans un répertoire commun.


Les données vectorielles
===============================================================

Quelques bonnes pratiques:

* **Noms des couches**

 - jamais d'accents dans les noms des couches
 - jamais de caractères spéciaux
 - pas 2 fois le même nom pour une couche ou un groupe

* **Nom des colonnes**

 - pas d'accents ni caractères spéciaux
 - des noms courts et simples
 
* **Encodage** : 

 - connaître l'encodage des couches et toujours utiliser le même. Au mieux utiliser l' **UTF-8**
 - éviter d'utiliser l'encodage appelé "système" dans QGIS, car l'encodage du serveur peut être différent de celui de votre système d'exploitation.


Configuration des propriétés du projet
===============================================================

Onglet Général
----------------------------------------------------

Menu *Préférences > Propriétés du projet* OU CTRL+MAJ+P

* **Enregistrer les chemins** : Toujours travailler en relatif !

  Cela permet de copier/coller un projet et des données dans un autre répertoire ou un autre ordinateur. **C'est indispensable pour que la carte fonctionne sur le serveur Lizmap**


Onglet Système de Coordonnées de Référence
----------------------------------------------------

SCR = **Système de coordonnées de références**

* Il faut toujours **définir un SCR** pour un projet QGIS
* Toujours activer la **reprojection à la volée**. QGIS sait reprojeter les raster et les vecteurs

Aide
  Pour choisir un SCR, il suffit de taper son code ou des premières lettres dans le champ texte du dessus, puis de cliquer dans la liste filtrée.


Onglet Serveur OWS
-------------------------------------------------------

Utilisé par QGIS Server : il permet de configurer comment les couches seront publiées en WMS et WFS.

Il faut toujours:

* Remplir les métadonnées textuelles
* Configurer l'emprise de la carte
* Ajouter des restrictions de projections : la projection principale du projet, et la projection Pseudo Mercator (EPSG:3857) si on souhaite utiliser des fonds externes (Google ou OpenStreetMap)
