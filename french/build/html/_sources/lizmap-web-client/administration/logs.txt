=============================
Gestion des logs dans Lizmap
=============================

Principe et description
========================

Depuis la version 2.8, il est possible de configurer *Lizmap Web Client* pour que certaines actions des utilisateurs soient enregistrées dans une base de données sqlite :

* Connexion des utilisateurs
* Affichage d'une carte Lizmap (correspondant à un projet QGIS)
* Impression d'une carte
* Affichage d'une popup
* Utilisation de l'outil d'édition

Pour chacune de ces actions, on peut choisir 

* d'enregistrer une nouvelle ligne dans les logs contenant différentes informations : utilisateur, date et heure, action, répertoire Lizmap, projet QGIS, adresse IP
* d'incrémenter le compteur pour cette action, le répertoire Lizmap et le projet QGIS.

Configurer les logs
====================

Pour l'instant, il n'est pas possible de modifier la configuration des logs via l'interface d'administration. Il est nécessaire d'éditer à la main le fichier de configuration **lizmap/var/config/lizmapLogConfig.ini.php**. Ce fichier est au format *ini* et contient autant de sections que d'actions à enregistrer. Pour chacune des actions, on peut choisir d'activer via *on* ou de désactiver avec *off* l'enregistrement du log.

Par exemple, la section suivante montre que l'administrateur a choisit d'enregistrer un décompte dans les logs chaque fois qu'un utilisateur se connecte. Mais qu'il ne souhaite pas enregistrer le détail pour chaque connexion.

.. code-block:: bash

   [item:login]
   label="User logs in"
   logCounter=on
   logDetail=off
   logIp=off

Consulter les logs
===================

Pour consulter les logs, il suffit de se connecter à l'interface d'administration de Lizmap en tant qu'administrateur. Ensuite les logs peuvent être consultés via le menu **LIZMAP > Logs LizMap**. Cette page montre les statistiques générales sur les 2 tables de logs: *Compteurs* et *Logs détaillés*. Pour chacun, il est possible de

* **Consulter les tableaux** qui contienent les données brutes
* **Vider complètement les logs** :remise à zéro complète !

Fichier de stockage des logs
=============================

La base de données des logs est située ici par rapport au répertoire d'installation : **lizmap/var/logs.db**. Par exemple

.. code-block:: bash

   # si Lizmap Web Client est installé ici : /var/www/lizmap-web-client-2.8.1/, le fichier est:
   /var/www/lizmap-web-client-2.8.1/lizmap/var/logs.db   


Cette base de données peut être consultée via un outil de lecture de base de données Sqlite, par exemple *SQLite Browser* ou l'extension Firefox *SQlite Manager*. Si vous connaissez le langage SQL, vous pourrez ainsi faire des requêtes pour extraire des informations à partir des logs détaillés.


