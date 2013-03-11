.. _media_in_lizmap:

===============================================================
Les médias dans Lizmap
===============================================================

Les médias - principe d'utilisation
===============================================================

Il est possible de mettre à disposition des documents à travers Lizmap. Pour cela il faut simplement:

* créer un répertoire intitulé *media* au même niveau que le projet QGIS
* *y mettre des documents*. On peut utiliser des sous-répertoires par couche ou par thème
* utiliser *un chemin relatif* dans la configuration de Lizmap : *media/mon/chemin/mon_document.pdf*
* des images, des rapports, des pdfs, des vidéos, des fichiers HTML ou texte.

*Les documents sont envoyés avec le plugin comme les autres données via la synchronisation FTP*


Utilisation pour les liens
===============================================================

Il est possible d'utiliser un chemin relatif vers un document pour les liens des couches ou des groupes

* *media/ma_couche/metadonnees_couche.pdf*
* *media/rapports/mon_rapport_sur_la_couche.doc*
* *media/une_image.png*

Sur la carte de Lizmap Web Client, l'icone (i) placée à droite de la couche permet d'ouvrir le document lié.

Exemple
  *Voir le groupe Transports du projet de démonstration Montpellier - Transports*

  
Utilisation dans les popups
===============================================================

Les popups affichent par défaut les valeurs contenues dans les colonnes pour l'objet sélectionné. Vous pouvez aussi utiliser des colonnes dont les valeurs sont *des chemins relatifs vers des fichiers du dossier media.* 

* Si le chemin pointe *vers une image*, l'image sera affichée dans la popup. 
* Si le chemin pointe *vers un fichier texte ou un fichier HTML*, le contenu du fichier sera affiché dans la popup. 
* Pour les *autres types de fichiers*, la popup affichera un lien vers le document, que les utilisateurs pourront télécharger.

Exemple
  *Voir les popups des couches Districts et trams du projet de démonstration Montpellier Transports*




