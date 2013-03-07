===============================================================
LINUX - Installation de Lizmap
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
   VERSION=2.4.1
   # récupération de l'archive via wget
   wget http://demo.3liz.com/download/$MYAPP-$VERSION.zip
   # on dézippze l'archive
   unzip $MYAPP-$VERSION.zip


Donner les droits adéquats aux répertoires et fichiers
--------------------------------------------------------------

.. code-block:: bash

   cd $MYAPP/$VERSION
   chown :www-data temp/ lizmap/var/ lizmap/www -R
   chmod 775 temp/ lizmap/var/ -R


Premier test
--------------------------------------------------------------

Aller à l'accueil de Lizmap pour voir si l'installation a été correctement réalisée : http://localhost/lizmap-web-client/2.4.1/lizmap/www/



Montée de version
===============================================================

Sauvegarde préalable
--------------------------------------------------------------

Avant de mettre à jour, faites une sauvegarde des données de configuration : lizmap/var/jauth.db and lizmap/var/config/lizmapConfig.ini.php


.. code-block:: bash

   MYAPP=lizmap-web-client
   OLDVERSION=2.4.0
   # if you installation is 2.1.0 or less, use an empty OLDVERSION instead : 
   # OLDVERSION=
   cp /var/www/$MYAPP/$OLDVERSION/lizmap/var/jauth.db /tmp/jauth.db # database containing groups and users
   cp /var/www/$MYAPP/$OLDVERSION/lizmap/var/config/lizmapConfig.ini.php /tmp/lizmapConfig.ini.php # text configuration file with services and repositories

Puis faites une installation classique de la nouvelle version, ce qui crééra un nouveau dossier dans le répertoire /var/www/lizmap-web-client


Copier les fichiers sauvegardés dans le dossier de la nouvelle version
--------------------------------------------------------------

.. code-block:: bash

   $VERSION=2.4.1
   cp /tmp/jauth.db /var/www/$MYAPP/$VERSION/lizmap/var/jauth.db
   cp /tmp/lizmapConfig.ini.php /var/www/$MYAPP/$VERSION/lizmap/var/config/lizmapConfig.ini.php

**IMPORTANT** Si vous montez de version depuis LizMap 2.3.0 ou inférieure jusqu'à la 2.4.0 ou supérieur, il faut aussi modifier la base de données sqlite de gestion des droits

.. code-block:: bash

   cd /var/www/$MYAPP/$VERSION/
   sqlite3 lizmap/var/jauth.db < lizmap/install/sql/upgrade_jacl2db_1.3_1.4.sql


Supprimer les fichiers temporaires de Jelix
--------------------------------------------------------------

.. code-block:: bash

   rm -rf /var/www/$MYAPP/$VERSION/temp/lizmap/*

Modifiez la configuration de votre hôte virtuel Apache pour que l'alias lizmap pointe vers le nouveau dossier (si vous aviez configuré un alias)

