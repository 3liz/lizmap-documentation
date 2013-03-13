===============================================================
Installation de Lizmap sous Linux Debian ou Ubuntu
===============================================================


Installation
===============================================================

Au préalable, vous devez avoir un serveur tournant avec Apache. Dans ce document, nous considérons que QGIS Server a aussi été installé correctement : http://hub.qgis.org/wiki/quantum-gis/QGIS_Server_Tutorial

Cette page ne décrit pas comment sécuriser votre serveur Apache.


Récupérer les librairies
--------------------------------------------------------------

.. code-block:: bash

   sudo su # utile seulement si vous n'êtes pas connecté en tant que root
   apt-get update # mise à jour des paquets
   apt-get install apache2 php5 curl php5-curl php5-sqlite php5-gd # installation de apache2, php, curl, gd et sqlite
   service apache2 restart # redémarrage du serveur Apache

Aller au répertoire www par défaut d'Apache (à modifier selon vos besoins)

.. code-block:: bash

   cd /var/www/

Récupérer et installer LizMap Web Client
--------------------------------------------------------------

.. code-block:: bash

   # options
   MYAPP=lizmap-web-client
   VERSION=2.7.0
   # récupération de l'archive via wget
   wget https://github.com/3liz/lizmap-web-client/archive/$VERSION.zip
   # on dézippze l'archive
   unzip $VERSION.zip
   # on supprime le zip
   rm $VERSION.zip


Donner les droits adéquats aux répertoires et fichiers
--------------------------------------------------------------

.. code-block:: bash

   cd /var/www/$MYAPP-$VERSION
   chown :www-data temp/ lizmap/var/ lizmap/www lizmap/install/qgis/annotations/ -R
   chmod 775 temp/ lizmap/var/ lizmap/install/qgis/annotations/ -R


Premier test
--------------------------------------------------------------

Aller à l'accueil de Lizmap pour voir si l'installation a été correctement réalisée : http://localhost/lizmap-web-client-2.7.0/lizmap/www/


Ajouter le support spatiatlite au PHP
==============================================================

Pour pouvoir utiliser les annotations sur des couches spatiatlite, il faut ajouter l'extension spatialite dans PHP. Vous pouvez suivre les instructions suivantes pour le faire :
http://www.gaia-gis.it/spatialite-2.4.0-4/splite-php.html

Lizmap Web Client teste si le support du spatialite est bien activé dans le php. S'il ne l'est pas, alors les couches spatialites ne seront pas utilisables dans l'outil d'annotation. Vous pouvez toujours utiliser des données PostGreSQL pour les annotations.


Montée de version
===============================================================

Sauvegarde préalable
--------------------------------------------------------------

Avant de mettre à jour, faites une sauvegarde des données de configuration : lizmap/var/jauth.db and lizmap/var/config/lizmapConfig.ini.php


.. code-block:: bash

   MYAPP=lizmap-web-client
   OLDVERSION=2.4.1
   # if you installation is 2.1.0 or less, use an empty OLDVERSION instead : 
   # OLDVERSION=
   cp /var/www/$MYAPP-$OLDVERSION/lizmap/var/jauth.db /tmp/jauth.db # database containing groups and users
   cp /var/www/$MYAPP-$OLDVERSION/lizmap/var/config/lizmapConfig.ini.php /tmp/lizmapConfig.ini.php # text configuration file with services and repositories

Puis faites une installation classique de la nouvelle version, ce qui crééra un nouveau dossier dans le répertoire /var/www/lizmap-web-client


Copier les fichiers sauvegardés dans le dossier de la nouvelle version
-----------------------------------------------------------------------

.. code-block:: bash

   $VERSION=2.7.0
   cp /tmp/jauth.db /var/www/$MYAPP-$VERSION/lizmap/var/jauth.db
   cp /tmp/lizmapConfig.ini.php /var/www/$MYAPP-$VERSION/lizmap/var/config/lizmapConfig.ini.php

**IMPORTANT** Si vous montez de version depuis LizMap 2.3.0 ou inférieure jusqu'à la 2.4.0 ou supérieur, il faut aussi modifier la base de données sqlite de gestion des droits

.. code-block:: bash

   cd /var/www/$MYAPP-$VERSION/
   sqlite3 lizmap/var/jauth.db < lizmap/install/sql/upgrade_jacl2db_1.3_1.4.sql


Supprimer les fichiers temporaires de Jelix
--------------------------------------------------------------

.. code-block:: bash

   rm -rf /var/www/$MYAPP-$VERSION/temp/lizmap/*
   
Redéfinir les droits sur les fichiers de l'application
-------------------------------------------------------

.. code-block:: bash

   cd /var/www/$MYAPP-$VERSION
   chown :www-data temp/ lizmap/var/ lizmap/www lizmap/install/qgis/annotations/ -R
   chmod 775 temp/ lizmap/var/ lizmap/install/qgis/annotations/ -R
