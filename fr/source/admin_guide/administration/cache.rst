===============================================================
Gestion du cache en tant qu'administrateur
===============================================================

Lizmap Web Client permet de générer automatique un cache des tuiles par le serveur au fur et à mesure que les utilisateurs accèdent aux cartes. Dans certains cas, il est souhaitable de pouvoir supprimer le cache serveur, par exemple lorsque des modifications de style ont été faites pour certaines couches spatialies publiées par Lizmap Web Client. Pour cela, 2 solutions sont possibles

Suppression de tout le cache par répertoire Lizmap
===================================================

Dans l'interface d'administration, le menu **Configuration Lizmap** montre la liste des *répertoires Lizmap* configurés. Pour chacun des répertoire, l'administrateur peut supprimer le cache pour toutes les couches de tous les projets du répertoire en cliquant sur le bouton **Vider le cache**.

Supprimer le cache couche par couche pour chaque projet Lizmap
==============================================================

Lorsque l'administrateur est connecté et qu'il consulte une carte Lizmap, une **petite croix rouge** est affichée à droite du nom de chaque couche qui est configurée pour être mise en cache serveur. Un clic sur cette croix permet, après validation, de supprimer le cache serveur uniquement pour cette couche de ce projet QGIS. Seul l'administrateur connecté voit ces croix rouges et a le droit de lancer la suppression.
