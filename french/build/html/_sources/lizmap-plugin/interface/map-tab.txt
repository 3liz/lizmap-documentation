.. _map_tab:

===============================================================
Carte - Configurer la carte web avec le plugin
===============================================================


L'onglet Carte
===============================================================

Cet onglet vous permet d'activer ou désactiver des outils élémentaires de Lizmap, de choisir les échelles et l'emprise initiale.

.. image:: ../MEDIA/interface-map-tab.png
   :align: center
   :width: 80%


Options générales
====================

Une seule option est pour l'instant disponible ici.

Masquer le projet dans Lizmap Web Client
------------------------------------------

Si cette case est cochée, le projet ne sera pas visible dans la page d'accueil de Lizmap qui montre les vignettes pour tous les répertoires et projets de l'application. Vous pouvez donc utiliser cette option pour masquer le projet.

Par contre, le projet sera toujours accessible pour les clients WMS ou WFS : ce n'est pas une protection totale du projet (pour cela, utiliser les droits par répertoire)

Cette fonctionnalité est intéressante dans le cas où on utilise des couches d'un autre projet Lizmap comme fonds de carte. Voir :ref:`lizmap_external_baselayers` On peut ainsi masquer le projet source.

Outils de la carte
===============================================================

Impression simple
------------------------

Pour proposer l'impression sur la carte en ligne, il faut que le projet QGIS ait au moins un composeur d'impression configuré.

L'application Lizmap Web Client montrera un menu avec une icône d'imprimante. Ce menu liste les composeurs d'impression du projet QGIS.

Lorsque l'utilisateur clique sur l'outil dans Lizmap Web Client, un rectangle est dessiné sur la carte en ligne. Ce rectangle représente le cadre de la carte du composeur d'impression. Les proportions sont équivalentes, ce qui permet d'assurer que la zone imprimée dans le pdf correspond exactement à ce que l'utilisateur choisit.

L'utilisateur peut alors :

* Choisir l'échelle d'impression, ce qui redimensionne le rectangle
* Zoomer
* Déplacer le rectangle

Une fois que le rectangle correspond à la zone souhaité, il suffit de cliquer sur le bouton **Imprimer** pour voir le PDF imprimé.

.. note:: Il est possible d'exclure des composeurs d'impression de la publication Web. Par exemple, si le projet QGIs contient 4 composeurs, l'administrateur du projet peut en exclure 2 via les *propriétés du projet QGIS*, onglet *Serveur OWS*. Alors ne seront présentés dans Lizmap que les composeurs publiés.

Outils de mesure
-------------------------

Lorsque cette option est activée, l'utilisateur de la carte en ligne voit le menu **Mesure** apparaître dans l'interface.

Lorsqu'il clique sur ce menu, une liste déroulante propose de mesurer

* une aire
* une longueur
* un périmètre

Pour réaliser la mesure, l'utilisateur clique sur la carte les points successifs de mesure. Un message affiche le résultat de la mesure au fil de l'ajout de points. Un double clic sur la carte permet de finaliser la mesure.

Zoom précédent/suivant
-------------------------

Cette option permet d'ajouter 2 boutons sous la barre de navigation (celle qui contient les boutons de zoom et la barre de sélection de l'échelle).

Tout déplacement sur la carte est enregistré : glisser-déplacer, zoom avant, zoom arrière. Ces 2 boutons permettent à l'utilisateur de revenir d'un ou plusieurs emprises en arrière ou en avant.

Positionnement automatique
--------------------------

Cette option ajoute dans l'interface un menu **Géolocalisation** .

Lorsque l'utilisateur active cet outil, une demande de positionnement est faite via le navigateur. En fonction de l'appareil utilisé et de la connexion internet, le navigateur peut:

* soit utiliser l'api de géolocalisation
* soit les données du GPS s'il existe et est activé.

Deux boutons sont alors présentés à l'utilisateur, pour centrer une fois sur la position ou pour maintenir un recentrage régulier.

Cet outil peut donc être intéressant si on souhaite consulter la carte Lizmap en ligne depuis son matériel mobile (smartphone, tablette durcie, etc.). Il faut une connection internet active et activer le GPS de l'appareil.


Recherche d'adresse
--------------------------

Il est possible de choisir un moteur externe de recherche d'adresses ou de lieux. Les moteurs disponibles sont les suivants:

* **Nominatim**

  C'est le moteur officiel du projet OpenStreetMap (http://osm.org et http://nominatim.openstreetmap.org/ ). Il permet de faire des recherches d'adresse, du type "Rue Foch, Montpellier" ou de points d'intérêts, du type "Tour eiffel" ou encore "Au panier gourmand, montpellier".

Important:  **La recherche d'adresse est limitée à l'emprise du projet QGIs spécifiée dans l'onglet "Serveur OWS" des propriétés du projet QGIS.**


Échelles
===============================================================

Lizmap vous permet de choisir les échelles d'affichage que vous souhaitez utiliser dans l'application Web. Vous pouvez donc renseigner une liste d'échelles via cette option.

Pour configurer les échelles, il suffit d'écrire une liste d'échelles entières séparées par une virgule (et optionnellement un espace), par exemple: *250000, 100000, 50000*.

Lizmap utilise aussi ces échelles pour restreindre l'affichage entre les échelles minimum et maximum données. C'est pourquoi **il est obligatoire de renseigner au moins 2 échelles** dans la liste

Les 2 échelles minimum et maximum sont automatiquement extraites et affichées pour rappel dans les champs situés sous le champ texte.


Emprise initiale
==================

L'emprise globale du projet QGIS est configurée dans l'onglet **Serveur OWS** des **propriétés du projet QGIS**. Lizmap utilise cette emprise globale comme emprise maximale de la carte : les données ne pourront pas être affichées si elles sont en dehors.

L'administrateur du projet peut choisir quel est l'emprise initiale de la carte lorsque les utilisateurs arrivent sur la carte. Par défaut, c'est l'emprise globale du projet.

Deux boutons permettent de modifier manuellement l'emprise de départ de la carte:

* **Définir à partir des propriétés du projet** : les valeurs sont recopiées depuis la configuration du projet, l'emprise globale est utilisée.
* **Définir à partir de la vue courante** : l'emprise actuelle de la carte dans QGIS est utilisée.
