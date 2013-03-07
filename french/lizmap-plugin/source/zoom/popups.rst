===============================================================
Configurer les popups dans Lizmap
===============================================================
 
Rappel sur les popups dans Lizmap
===============================================================

Via le plugin, on peut activer les popups 

* pour une couche
* pour un groupe. Seules les couches filles qui ont aussi l'option Popup activée seront visibles
* les popups ne sont pas utilisables pour les fonds de carte


Configuration simple des popups
===============================================================

On peut utiliser les outils de *l'onglet Champs* des propriétés de chaque couche pour:

* *Ne pas afficher* une colonne : *Outil d'édition > Cachée*
* *Modifier le nom* qui sera affiché pour la colonne : *colonne Alias*

Si on utilise des chemins vers les documents du répertoire media, on peut

* *afficher l'image* correspondante
* *afficher le contenu texte ou HTML* du fichier correspondant
* *afficher un lien* vers le document

On peut aussi utiliser dans les colonnes des liens WEB complets vers une page ou une image

.. image:: media/popup_col_champs.png
   :align: center
   :width: 70%



Configuration avancée des popups au format HTML
===============================================================

Via le *bouton Configurer* du plugin Lizmap, on peut modifier le modèle de la popup

* Si le contenu est vide, un tableau sera présenté (modèle par défaut)
* Si le contenu n'est pas vide, il sera affiché à la place

On peut écrire du texte simple, mais il est conseillé d'écrire au format HTML pour le mettre en forme. La fenêtre montre:

* une zone de texte éditable qui permet d'écrire le contenu
* une zone de texte en lecture seule qui montre un aperçu de la mise en forme


.. image:: media/popup_configurer.png
   :align: center
   :width: 70%


Pour ajouter le contenu d'une colonne dans la popup, on utilise le format *{$nom_champ}* 

Attention
  Si vous avez configuré un alias pour un champ, il faut utiliser l'alias au lieu du nom : *{$alias}*
  
On peut encore utiliser les valeurs des colonnes comme paramètres :

<p style="background-color:{$color}">
<b>LINE</b> : {$ref} - {$name}
<p/>

Conseil
  Utiliser un éditeur HTML externe pour faciliter la mise en forme
  
  
  


