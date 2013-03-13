===============================================================
Ajouter une carte miniature
===============================================================
 
Principe et utilisation
===============================================================

Pour ajouter une **carte miniature** dans la carte Lizmap, il suffit de

* créer un groupe indépendant dans le projet QGIS qui s'appelle **Overview** (avec la majuscule à la 1ère lettre)
* **Y ajouter des couches**, par exemple une couche de communes, un fond relief allégé, etc.

L'ensemble des couches et groupes du groupe *Overview* ne sera **pas affiché dans la légende** de la carte Lizmap, mais seulement dans la carte miniature.


Il est conseillé d'utiliser

* des couches vectorielles **légères et simplifiées** si nécessaire
* d'utiliser une **sémiologie adaptée** : traits fins et étiquettes cachées ou petites


Voici un exemple d'utilisation:

.. image:: ../MEDIA/features-overview.png
   :align: center
   :width: 60%


