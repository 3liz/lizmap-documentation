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

Depuis le fichier ZIP
~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

   cd /var/www/
   # options
   MYAPP=lizmap-web-client
   VERSION=2.11.0
   # récupération de l'archive via wget
   wget https://github.com/3liz/lizmap-web-client/archive/$VERSION.zip
   # on dézippze l'archive
   unzip $VERSION.zip
   # on supprime le zip
   rm $VERSION.zip

Version de développement avec Github
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


.. note:: Attention, la version de développement est en constante évolution, et des bugs peuvent survenir. Ne pas l'utiliser en production.

* Pour installer

.. code-block:: bash

   cd /var/www/
   MYAPP=lizmap-web-client
   VERSION=master
   # cloner la branche master
   git clone https://github.com/3liz/lizmap-web-client.git $MYAPP-$VERSION
   # aller dans le dépôt git
   cd $MYAPP-$VERSION
   # créer une branche personnelle pour les éventuelles modifications
   git checkout -b mybranch


* Pour mettre à jour votre branche depuis le dépôt master

.. code-block:: bash


   cd /var/www/$MYAPP-$VERSION
   # vérifier que vous êtes bien sur la branche mybranch
   git checkout mybranch
   # Si vous avez des modifications, faire un commit
   git status
   git commit -am "Votre message de commit"
   # sauvegarder vos fichiers de configuration !
   cp lizmap/var/jauth.db /tmp/jauth.db && cp lizmap/var/logs.db /tmp/logs.db && cp lizmap/var/config/lizmapConfig.ini.php /tmp/lizmapConfig.ini.php
   # Mettre à jour votre branche master
   git checkout master && git fetch origin && git merge origin/master
   # Appliquer sur votre branche, et gérer les éventuels conflits de merge
   git checkout mybranch && git rebase master
   # réappliquer les droits
   chown :www-data temp/ lizmap/var/ lizmap/www lizmap/install/qgis/edition/ -R
   chmod 775 temp/ lizmap/var/ lizmap/www lizmap/install/qgis/edition/ -R

.. note:: Il est toujours bon de faire une sauvegarde avant toute mise à jour.



Donner les droits adéquats aux répertoires et fichiers
--------------------------------------------------------------

.. code-block:: bash

   cd /var/www/$MYAPP-$VERSION
   chown :www-data temp/ lizmap/var/ lizmap/www lizmap/install/qgis/edition/ -R
   chmod 775 temp/ lizmap/var/ lizmap/www lizmap/install/qgis/edition/ -R


Premier test
--------------------------------------------------------------

Aller à l'accueil de Lizmap pour voir si l'installation a été correctement réalisée : http://localhost/lizmap-web-client-2.10.0/lizmap/www/


Outil d'édition : Configurer le serveur avec le support des bases de données
=============================================================================

PostGreSQL
------------------------------

Pour que l'édition de couches PostGIS dans Lizmap Web Client fonctionnent, il faut installer le support de PostGreSQL pour PHP.

.. code-block:: bash

   sudo apt-get install php5-pgsql
   sudo service apache2 restart

.. note:: Pour l'édition, nous conseillons fortement d'utiliser une base de données PostGreSQL. Cela simplifie fortement l'installation et la récupération des données saisies par les utilisateurs.


Spatialite
------------------------------

Activer l'extension Spatialite
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Pour pouvoir utiliser l'édition sur des couches spatiatlite, il faut ajouter l'extension spatialite dans PHP. Vous pouvez suivre les instructions suivantes pour le faire :
http://www.gaia-gis.it/spatialite-2.4.0-4/splite-php.html

Lizmap Web Client teste si le support du spatialite est bien activé dans le php. S'il ne l'est pas, alors les couches spatialites ne seront pas utilisables dans l'outil d'édition. Vous pouvez toujours utiliser des données PostGreSQL pour l'édition.

Donner les droits adéquats au répertoire contenant les bases de données Spatialite
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Pour que l'application Lizmap Web Client puisse modifier les données contenues dans les bases Spatialite, il faut s'assurer que **l'utilisateur Apache (www-data) ait bien les droits en écriture sur le répertoire contenant chaque fichier spatialite**.

Par exemple, si un répertoire contient un projet QGIS, qui utilise une base de données Spatialite placée dans un répertoire **bdd** au même niveau que le projet QGIS:

.. code-block:: bash

   /un/chemin/vers/un_repertoire_lizmap
   |--- mon_projet.qgs
   |--- bdd
      |--- mon_fichier_spatialite.sqlite

Alors il faut donner les droits de cette manière:

.. code-block:: bash

   chown :www-data /un/chemin/vers/un_repertoire_lizmap/ -R
   chmod 775 /un/chemin/vers/un_repertoire_lizmap/ -R

.. note:: c'est pourquoi, si vous souhaitez installer Lizmap pour offrir un accès à plusieurs utilisateurs, nous vous conseillons de leur dire de toujours créer un répertoire bdd au même niveau que les projets QGIS dans le répertoire Lizmap. Cela facilitera le travail de l'administrateur qui pourra modifier les droits de cet unique répertoire.

Montée de version
===============================================================

Sauvegarde préalable
--------------------------------------------------------------

Avant de mettre à jour, faites une sauvegarde des données de configuration : lizmap/var/jauth.db and lizmap/var/config/lizmapConfig.ini.php et du fichier de log (à partir de la 2.8) lizmap/var/logs.db


.. code-block:: bash

   MYAPP=lizmap-web-client
   OLDVERSION=2.8.1 # replace by the version number of your current lizmap installation
   # if you installation is 2.1.0 or less, use an empty OLDVERSION instead :
   # OLDVERSION=
   cp /var/www/$MYAPP-$OLDVERSION/lizmap/var/jauth.db /tmp/jauth.db # base de données utilisateur
   cp /var/www/$MYAPP-$OLDVERSION/lizmap/var/config/lizmapConfig.ini.php /tmp/lizmapConfig.ini.php # text configuration file with services and repositories
   cp /var/www/$MYAPP-$OLDVERSION/lizmap/var/logs.db /tmp/logs.db # lizmap logs

Puis faites une installation classique de la nouvelle version (voir ci-dessus), ce qui crééra un nouveau dossier dans le répertoire /var/www/


Copier les fichiers sauvegardés dans le dossier de la nouvelle version
-----------------------------------------------------------------------

.. code-block:: bash

   $VERSION=2.10.0
   cp /tmp/jauth.db /var/www/$MYAPP-$VERSION/lizmap/var/jauth.db
   cp /tmp/lizmapConfig.ini.php /var/www/$MYAPP-$VERSION/lizmap/var/config/lizmapConfig.ini.php
   cp /tmp/logs.db /var/www/$MYAPP-$VERSION/lizmap/var/logs.db

.. note:: Pour certaines versions, il est aussi nécessaire de mettre à jour la base de données qui stocke les droits. Voir les points suivants pour plus de détail.

De la version 2.3.0 ou inférieure à la 2.4.0 ou supérieure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Les librairies Jelix (outil avec lequel est construit Lizmap Web Client) a été mis à jour. Il faut modifier la base de données sqlite de gestion des droits :

.. code-block:: bash

   cd /var/www/$MYAPP-$VERSION/
   sqlite3 lizmap/var/jauth.db < lizmap/install/sql/upgrade_jacl2db_1.3_1.4.sql

De la version 2.6 ou inférieure à la version 2.7
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Le support des annotations a été ajouté à Lizmap, ainsi que la gestion des droits liée. Il faut donc modifier la base de données des droits pour mettre à niveau :

.. code-block:: bash

   cd /var/www/$MYAPP-$VERSION/
   sqlite3 lizmap/var/jauth.db < lizmap/install/sql/upgrade_jacl2db_lizmap_from_2.0_and_above_to_2.5.sql


De la version 2.7.*  à la version 2.8
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

L'outil d'édition a remplacé l'outil d'annotation et nous avons ajouté des champs pour décrire chaque utilisateur Lizmap. Il faut mettre à jour la base de donnée de gestion des droits:

.. code-block:: bash

   cd /var/www/$MYAPP-$VERSION/
   sqlite3 lizmap/var/jauth.db < lizmap/install/sql/upgrade_jacl2db_2.7_2.8.sql

De la version 2.8.*  à la version 2.9
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La fonctionnalité de filtrage des données des couches en fonction de l'utilisateur connecté nécessite l'ajout des droits liés dans la base de données des utilisateurs:

.. code-block:: bash

   cd /var/www/$MYAPP-$VERSION/
   sqlite3 lizmap/var/jauth.db < lizmap/install/sql/upgrade_jacl2db_2.8_2.9.sql

De la version 2.9.*  à la version 2.10
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La fonctionnalité de filtrage des données des couches en fonction de l'utilisateur connecté nécessite l'ajout des droits liés dans la base de données des utilisateurs:

.. code-block:: bash

   cd /var/www/$MYAPP-$VERSION/
   sqlite3 lizmap/var/jauth.db < lizmap/install/sql/upgrade_jacl2db_2.9_2.10.sql

Supprimer les fichiers temporaires de Jelix
--------------------------------------------------------------

.. code-block:: bash

   rm -rf /var/www/$MYAPP-$VERSION/temp/lizmap/*

Redéfinir les droits sur les fichiers de l'application
-------------------------------------------------------

.. code-block:: bash

   cd /var/www/$MYAPP-$VERSION
   chown :www-data temp/ lizmap/var/ lizmap/www lizmap/install/qgis/edition/ -R
   chmod 775 temp/ lizmap/var/ lizmap/www lizmap/install/qgis/edition/ -R
