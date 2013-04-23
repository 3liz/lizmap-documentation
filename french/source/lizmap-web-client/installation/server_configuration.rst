===============================================================
Configuration du serveur cartographique Lizmap
===============================================================

Cette documentation présente un exemple de configuration d'un serveur sous la distribution Ubuntu Server 12.04 LTS. 

Configuration générique du serveur
===============================================================

Configurer les locales
--------------------------------------------------------------

Pour simplifier les choses, il est intéressant de configurer le serveur avec l'encodage par défaut UTF-8

.. code-block:: bash

   # locales
   locale-gen fr_FR.UTF-8
   dpkg-reconfigure locales
   dpkg-reconfigure tzdata

.. note:: Il faudra aussi configurer les autres logiciels pour qu'ils utilisent cet encodage par défaut si ce n'est pas le cas.

Installation de quelques librairies utiles
-------------------------------------------

* On met à jour les paquets

.. code-block:: bash

   # Mise à jour des paquets
   apt-get update
   apt-get upgrade

* On installe l'ensemble des paquets qu'on utilisera pour ce serveur cartographique

.. code-block:: bash

   apt-get install python-simplejson xauth htop nano curl ntp ntpdate python-software-properties git


Création des répertoires pour les données
-------------------------------------------

.. code-block:: bash

   mkdir /home/data
   mkdir /home/data/cache/
   mkdir /home/data/ftp
   mkdir /home/data/ftp/template/
   mkdir /home/data/ftp/template/qgis
   mkdir /home/data/postgresql
   

Serveur Web : Apache
======================================

Installation des paquets nécessaires
-------------------------------------

.. code-block:: bash

   apt-get install apache2 apache2-mpm-worker libapache2-mod-fcgid php5-cgi php5-curl php5-cli php5-sqlite php5-gd
   a2dismod php5
   a2enmod actions
   a2enmod fcgid
   a2enmod ssl
   a2enmod rewrite


Configuration de php5
-----------------------

On utilise dans cet exemple le mpm-worker d'Apache. On doit donc configurer manuellement l'activation de php5.

.. code-block:: bash

   cat > /etc/apache2/conf.d/php.conf << EOF
   <Directory /usr/share>
     AddHandler fcgid-script .php
     FCGIWrapper /usr/lib/cgi-bin/php5 .php
     Options ExecCGI FollowSymlinks Indexes
   </Directory>

   <Files ~ (\.php)>
     AddHandler fcgid-script .php
     FCGIWrapper /usr/lib/cgi-bin/php5 .php
     Options +ExecCGI
     allow from all
   </Files>
   EOF

   
Configuration du mpm-worker
-----------------------------

On modifie le fichier de configuration d'Apache pour adapter les options du mpm_worker à la configuration du serveur

.. code-block:: bash

   # configuration worker
   nano /etc/apache2/apache2.conf # aller au worker et mettre par exemple
   <IfModule mpm_worker_module>
     StartServers       4
     MinSpareThreads    25
     MaxSpareThreads    100
     ThreadLimit          64
     ThreadsPerChild      25
     MaxClients        150
     MaxRequestsPerChild   0
   </IfModule>

Configuration de mod_fcgid
---------------------------

QGIS Server fonctionne en mode fcgi. Il faut donc configurer le mod_fcgid d'Apache pour l'adapter aux capacités du serveur.

.. code-block:: bash

   # Ouvrir le fichier de configuration de mod_fcgid
   nano /etc/apache2/mods-enabled/fcgid.conf
   # Coller le contenu suivant en l'adaptant
   <IfModule mod_fcgid.c> 
     AddHandler    fcgid-script .fcgi
     FcgidConnectTimeout 300
     FcgidIOTimeout 300
     FcgidMaxProcessesPerClass 50
     FcgidMinProcessesPerClass 20
     FcgidMaxRequestsPerProcess 500
     IdleTimeout   300
     BusyTimeout   300
   </IfModule>


Redémarrer Apache
------------------

Il faut redémarrer le serveur Apache pour valider la configuration

.. code-block:: bash

   service apache2 restart


SGBD Spatial : PostGreSQL
============================================

Il peut être très intéressant d'utiliser PostGreSQL et PostGIS pour gérer les données spatiales de manière centralisée sur le serveur.

Installation
-------------

.. code-block:: bash

   # Installation des paquets
   apt-get install postgresql postgresql-contrib postgis pgtune php5-pgsql

   # On recrée un cluster pour pouvoir spécifier le répertoire de stockage
   mkdir /home/data
   mkdir /home/data/postgresql
   service postgresql stop
   pg_dropcluster --stop 9.1 main
   chown postgres:postgres /home/data/postgresql
   pg_createcluster 9.1 main -d /home/data/postgresql --locale fr_FR.UTF8 -p 5678 --start
   
   # On crée un utilisateur "superuser"
   su - postgres
   createuser myuser --superuser
   # On modifie les mots de passe
   psql
   ALTER USER postgres WITH ENCRYPTED PASSWORD '************';
   ALTER USER myuser WITH ENCRYPTED PASSWORD '************';
   \q
   exit

Adapatation de la configuration de PostGreSQL
----------------------------------------------

Nous allons utiliser pgtune, un utilitaire qui permet de générer automatiquement un fichier de configuration de PostGreSQL adapté aux propriétés du serveur (mémoire vive, processeurs, etc.)

.. code-block:: bash

   # PostgreSQL Tuning avevc pgtune
   pgtune -i /etc/postgresql/9.1/main/postgresql.conf -o /etc/postgresql/9.1/main/postgresql.conf.pgtune --type Web
   cp /etc/postgresql/9.1/main/postgresql.conf /etc/postgresql/9.1/main/postgresql.conf.backup
   cp /etc/postgresql/9.1/main/postgresql.conf.pgtune /etc/postgresql/9.1/main/postgresql.conf  
   nano /etc/postgresql/9.1/main/postgresql.conf
   # On redémarre pour voir si pas de problèmes
   service postgresql restart
   # Si message d'erreur, il faut augmenter les variables de configuration du noyau linux
   echo "kernel.shmall = 4294967296" >> /etc/sysctl.conf # pour shared_buffers à 3000Mo
   echo "kernel.shmmax = 4294967296" >> /etc/sysctl.conf
   echo 4294967296 > /proc/sys/kernel/shmall
   echo 4294967296 > /proc/sys/kernel/shmmax
   sysctl -a | sort | grep shm     
   # On redémarre PostGreSQL
   service postgresql restart


Serveur FTP: pure-ftpd
=======================

Installation
---------------

.. code-block:: bash

   apt-get install pure-ftpd pure-ftpd-common
   
Configuration
---------------

.. code-block:: bash

   # création d'un shell vide pour les utilisateurs
   ln /bin/false /bin/ftponly
   # On configure le serveur FTP
   echo "/bin/ftponly" >> /etc/shells
   # On bloque chaque utilisateur dans son home
   echo "yes" > /etc/pure-ftpd/conf/ChrootEveryone
   # On permet d'utiliser le FTP sécurisé via SSL
   echo "1" > /etc/pure-ftpd/conf/TLS
   # On configure les propriétés des répertoires et fichiers créés par les utilisateurs
   echo "133 022" > /etc/pure-ftpd/conf/Umask
   # La plage de ports pour le mode passif (à ouvrir vers l'extérieur)
   echo "5500 5700" > /etc/pure-ftpd/conf/PassivePortRange
   # On crée un certificat SSL pour le FTP
   openssl req -x509 -nodes -newkey rsa:1024 -keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem 
   chmod 400 /etc/ssl/private/pure-ftpd.pem
   # On redémarre le serveur FTP
   service pure-ftpd restart 

Création d'un compte utilisateur
--------------------------------

.. code-block:: bash

   # créer un compte utilisateur
   MYUSER=demo
   useradd -g client -d /home/data/ftp/$MYUSER -s /bin/ftponly -m $MYUSER -k /home/data/ftp/template/
   passwd $MYUSER
   # on ne permet pas de modifier la racine du ftp
   chmod a-w /home/data/ftp/$MYUSER 
   # On crée des répertoires vides qui seront les futurs répertoires lizmap
   mkdir /home/data/ftp/$MYUSER/qgis/rep1 && chown $MYUSER:client /home/data/ftp/$MYUSER/qgis/rep1
   mkdir /home/data/ftp/$MYUSER/qgis/rep2 && chown $MYUSER:client /home/data/ftp/$MYUSER/qgis/rep2
   mkdir /home/data/ftp/$MYUSER/qgis/rep3 && chown $MYUSER:client /home/data/ftp/$MYUSER/qgis/rep3
   mkdir /home/data/ftp/$MYUSER/qgis/rep4 && chown $MYUSER:client /home/data/ftp/$MYUSER/qgis/rep4
   mkdir /home/data/ftp/$MYUSER/qgis/rep5 && chown $MYUSER:client /home/data/ftp/$MYUSER/qgis/rep5
   # On crée un répertoire pour stocker le cache serveur de Lizmap
   mkdir /home/data/cache/$MYUSER
   chmod 700 /home/data/cache/$MYUSER -R
   chown www-data:www-data /home/data/cache/$MYUSER -R 


Serveur cartographique: QGIS Server
====================================

Installation
---------------

.. code-block:: bash

   # Ajout du dépôt UbuntuGis
   add-apt-repository ppa:ubuntugis/ubuntugis-unstable
   apt-get update
   # Installation de QGIS Server
   apt-get install qgis-mapserver
   
