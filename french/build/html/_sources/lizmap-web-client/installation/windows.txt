===============================================================
Installation de Lizmap sous Windows
===============================================================

Cette documentation présente le déroulement de l'installation de Lizmap Web Client sur un environnement  Windows 7. Les autres versions de Windows ne devraient pas poser de problème. Afin de faciliter l'installation, nous utilisons le logiciel OSGeo4W, qui permet d'installer l'ensemble des composants nécessaires de manière centralisée.

.. note:: Dans ce document, nous utilisons la version 2.8.0 de Lizmap. Veuillez à adapter en fonction de la version que vous souhaitez installer (la dernière est recommandée)

Installation
===============================================================

1. Télécharger OSGeo4W sur la page de téléchargement de QGIS

http://hub.qgis.org/projects/quantum-gis/wiki/DownloadFr#Installateur-R%C3%A9seau-OSGeo4W

2. Lancer l'installateur OSGeo4W et choisir l'installation avancée

.. image:: ../MEDIA/installation-osgeo4w-01.jpg
   :align: center


3. Utiliser l'installation par internet

.. image:: ../MEDIA/installation-osgeo4w-02.jpg
   :align: center

4. Sélectionner la racine pour l'installation des éléments d'OSGeo4W et préférer l'option d'accessibilité à tous les utilisateurs


.. image:: ../MEDIA/installation-osgeo4w-03.jpg
   :align: center

5. Sélectionner la racine des paquets locaux


.. image:: ../MEDIA/installation-osgeo4w-04.jpg
   :align: center

6. Préciser le type de connexion internet (via un proxy ou non)

.. image:: ../MEDIA/installation-osgeo4w-05.jpg
   :align: center

7. Sélectionner dans 'Desktop' le paquet 'QGIS-full'

.. image:: ../MEDIA/installation-osgeo4w-06.jpg
   :align: center

8. Sélectionner dans 'Web' le paquet 'QGIS-server'

.. image:: ../MEDIA/installation-osgeo4w-07.jpg
   :align: center

9. Sélectioner dans 'Lib' le paquet 'fcgi'

.. image:: ../MEDIA/installation-osgeo4w-08.jpg
   :align: center

10. Lancer et terminer l'installation

A cette étape tout ce qui est nécessaire à LizMap est installé sur votre machine.
Les étapes suivantes consistent à configurer le serveur, installer LizMap et de configurer LizMap.

11. Vérification d'Apache

Afin de vérifier que le serveur est bien installé ouvrir dans le navigateur l'adresse http://localhost

Si rien ne s'affiche c'est que l'installation n'a pas réussi.

12. Vérification de PHP

Cliquer sur le lien 'phpinfo' de la page d'accueil du serveur apache d'OSGeo4W. Cette page permet de vérifier la configuration de votre serveur. Vous devriez y trouver des informations sur cgi-fcgi, PDO et PDO_sqlite mais pas sur CURL ni GD dont dépend LizMap. 

.. image:: ../MEDIA/installation-osgeo4w-09.jpg 
   :align: center

.. image:: ../MEDIA/installation-osgeo4w-10.jpg
   :align: center

13. Activer CURL et GD2

Ouvrir le fichier C:\OSGeo4W\bin\PHP.ini et dé-commenter l'extension curl et gd2

.. image:: ../MEDIA/installation-osgeo4w-11.jpg
   :align: center

14. Rédémarrer Apache

La modification du fichier C:\OSGeo4W\bin\PHP.ini afin d'activer CURL et GD dans PHP, oblige à redémarrer le serveur apache. Pour ce faire, 

* cliquer dans le menu principal de windows sur le moniteur apache 'Tous les programmes > OSGeo4W > Apache > OSGeo4W-Apache-Monitor'.

  .. image:: ../MEDIA/installation-osgeo4w-12.png
     :align: center

* Cliquer sur le moniteur apache qui se trouve parmi les icônes cachées de la barre des tâches (en bas à droite) et sur 'Restart'. 

  .. image:: ../MEDIA/installation-osgeo4w-13.png
     :align: center

16. Vérfier CURL et GD

Dans le navigateur web, recharger la page 'phpinfo'. Vous devriez y trouver une section CURL et GD. 

.. image:: ../MEDIA/installation-osgeo4w-14.jpg
   :align: center

17. Télécharger LizMap

Le code de Lizmap Web Client est libre et téléchargeable sur github. Pour télécharger la dernière version:

* allez sur https://github.com/3liz/lizmap-web-client/tags 
* Cliquez sur le petit lien *zip* de la dernière version. Par exemple le lien suivant pour la 2.8.0 : https://github.com/3liz/lizmap-web-client/archive/2.8.0.zip


18. Décompresser LizMap dans 'C:\OSGeo4W\apache\htdocs\lizmap'

Vous devez maintenant avoir un dossier 'C:\OSGeo4W\apache\htdocs\lizmap\lizmap-web-client-2.8.0\' 

19. Test l'installation de Lizmap

Tester si LizMap est bien installé en ouvrant dans le navigateur l'adresse http://localhost/lizmap/lizmap-web-client-2.8.0/lizmap/www. Vous devriez y voir s'afficher le projet "Montpellier" fourni avec LizMap et configurer pour être visible par tous. Pour pouvoir consulter les cartes, il va falloir configurer LizMap.

20. Interface d'administration

Aller à l'adresse http://localhost/lizmap/lizmap-web-client-2.8.0/lizmap/www/admin.php et se connecter avec le login / mot de passe : 'admin/admin'.

21. Modifier l'URL de QGIS Server

* Cliquer sur 'Configuration LizMap' puis sur modifier dans la section Services afin de préciser l'url de votre QGIS-Server.

* Remplacer l'url du serveur WMS par http://127.0.0.1/qgis/qgis_mapserv.fcgi.exe et enregistrer : 

.. image:: ../MEDIA/installation-osgeo4w-17.jpg
   :align: center

23. Vérification

Afin de s'assurer que la configuration a bien réussi, cliquer sur 'Liste des projets' en haut. Vous devriez avoir accès à deux cartes puisque vous êtes authentifié comme administrateur. Cliquer sur l'une des cartes. Si la configuration est bonne vous devriez visualiser la carte, et donc être en possession d'une version de LizMap prête pour vos cartes.


Ajouter le support spatiatlite au PHP
==============================================================

Pour pouvoir utiliser les annotations sur des couches spatiatlite, il faut ajouter l'extension spatialite dans PHP. Malheureusement, il faut une version de PHP au moins égale à la 5.3 pour le faire, et pour l'instant, l'installateur OSGeo4W ne propose que la 5.2. 

*Il n'est donc pas possible pour l'instant sous Windows d'utiliser des couches Spatialite pour l'annotation.*

Lizmap Web Client teste si le support du spatialite est bien activé dans le PHP. S'il ne l'est pas, alors les couches Spatialite ne seront pas utilisables dans l'outil d'annotation. Vous pouvez toujours utiliser des données PostGreSQL à la place.
