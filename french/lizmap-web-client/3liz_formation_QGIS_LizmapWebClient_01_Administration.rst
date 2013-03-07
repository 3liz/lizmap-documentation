===============================================================
 Formation LizMap Web Client - Interface d'administration
===============================================================

:Author: Michaël DOUCHIN - 3liz
:Date:   2012-12
:Copyright: CC-BY-NC

Comment gérer les répertoires Lizmap et les utilisateurs.

Durée
 1h
 

Accéder à l'interface d'administration
---------------------------------------

Par souci de sécurité, aucun lien ne mène vers l'interface d'administration. L'adresse est la suivante

http://mondomaine.lizmap.3liz.com/admin.php

Identifiants temporaires

* login = admin
* mot de passe = admin
  
Application
  *Se connecter à votre interface*

Accéder à l'interface d'administration
---------------------------------------------

.. image:: media/lwc_accueil_admin.png
   :align: center
  
Modifier son mot de passe
--------------------------

Une fois connecté, on peut modifier son mot de passe 

* Cliquer sur votre login dans le menu en haut à droite puis *Votre compte*
* Cliquer sur le bouton *Changer votre mot de passe*
* Donner le nouveau mot de passe, confirmer et enregistrer

Attention
  *Il est impératif de modifier votre mot de passe. Utilisez un mot de passe complexe qui mélange chiffres, lettres et ponctuation*

Rappel sur les répertoires Lizmap
----------------------------------

Lizmap Web Client peut utiliser les cartes QGIS enregistrées dans différents répertoires sur le serveur.

* Un *répertoire Lizmap* est un dossier sur le serveur où sont stockés un ou plusieurs projet QGIS et les données liées.
* On peut utiliser les répertoires pour *regrouper des projets liés par une thématique*
* On peut utiliser les répertoires pour *gérer les droits d'accès sur les cartes*


Les groupes et les utilisateurs : principes
--------------------------------------------

En tant qu'administrateur, vous pouvez

* créer, renommer, supprimer des groupes d'utilisateurs
* créer, modifier, supprimer des utilisateurs
* rattacher un utilisateur à un ou plusieurs groupes

Lizmap
  *Les droits sur les répertoires Lizmap sont gérés au niveau des groupes d'utilisateurs, pas au niveau des utilisateurs*
  
Gérer les groupes : créer, renommer, supprimer
----------------------------------------------

* *Créer un groupe* : Menu *Groupes d'utilisateurs* et descendre jusqu'au formulaire *Créer un groupe*
* *Donné un libellé* : il est possible d'utiliser des espaces et des accents
* Donner un identifiant : un seul mot sans caractères spéciaux

Via cette page, on peut aussi *renommer ou supprimer un groupe*

Application
  1. *Supprimer le groupe "lizadmins" et "Intranet demo group"*
  2. *Créer un groupe "prive" qui contiendra les utilisateurs ayant accès aux cartes privées*


Gérer les groupes : créer
---------------------------------------------

.. image:: media/lwc_creer_groupe.png
   :align: center



Gérer les utilisateurs
-----------------------

* *Créer* : Menu *Utilisateurs > Créer un nouvel utilisateur*: donner un identifiant, un email et un mot de passe
* On peut aussi *modifier un utilisateur existant*

Application
  *Créer un ou plusieurs utilisateurs*

Lizmap
  *Une fois les utitilisateurs créés, il faut les mettre dans des groupes pour leur assigner les droits liés*

Gérer les utilisateurs
---------------------------------------------

.. image:: media/lwc_liste_utilisateur.png
   :align: center


  
Mettre les utilisateurs dans des groupes
-----------------------------------------

* Menu *Droits des utilisateurs*
* On peut filtrer les utilisateurs visibles via la liste déroulante
* Pour mettre les utilisateurs, utiliser le bouton *Droits*

 * La page affiche un tableau avec *les droits en ligne et les groupes en colonne*
 * La dernière colonne affiche *les droits résultants*
 * Dans la *ligne d'entête*, des boutons + et - permettent de mettre/enlever l'utilisateur dans un groupe
 * *CONSEIL* : ne pas utiliser la colonne *Droits personnels*


Application
  Assigner des groupes pour chacun des utilisateurs créés


Mettre les utilisateurs dans des groupes
---------------------------------------------

.. image:: media/lwc_liste_droits_utilisateurs.png
   :align: center

Mettre les utilisateurs dans des groupes
---------------------------------------------

.. image:: media/lwc_groupes_utilisateur.png
   :align: center


La Configuration Lizmap : services et répertoires
---------------------------------------------------

Le menu *Configuration Lizmap* est divisée en 2 parties

* Les *Services* : la configuration générale de Lizmap Web Client - serveur, cache, etc.
* Les *Répertoires* : créer et configurer les répertoires Lizmap


La Configuration Lizmap : services et répertoires
-------------------------------------------------

.. image:: media/lwc_configuration_lizmap.png
   :align: center



Configuration Lizmap : les services
------------------------------------

Pour configurer les services, cliquer sur le bouton *Modifier* situé sous le récapitulatif

* *URL du serveur WMS* : QGIS Server doit être installé sur le même ordinateur que Lizmap Web Client
* *Type de stockage pour le cache*

 * *file*: Les tuiles mises en cache sont stockées dans un répertoire du serveur par couche
 * *sqlite*: Les tuiles sont enregistrées dans une base de données sqlite par couche
 
* *Répertoire racine du cache* : le dossier dans lequel est stocké le cache. Il doit être accessible en écriture par le serveur Apache

Configuration Lizmap : les services
------------------------------------

* *Durée de vie du cache* : le temps en seconde pendant lequel chaque tuile est conservée. C'est une valeur par défaut pour les couches dont le temps n'a pas été configuré via le plugin

 * Les tuiles du cache plus vieilles que ce temps sont automatiquement raffraîchies.
 * La valeur 0 signigie que les tuiles n'expirent jamais
 * Le temps d'expiration doit être adapté à l'évolution des données
 
* *Envoi des requêtes à QGIS Server avec* : 2 méthodes. *Php ou Curl* . Utiliser la première si curl n'est pas installé sur le serveur
* *Mode de débogage* : enregistre certaines requêtes dans un fichier de log : *lizmap/var/log/messages.log*

Configuration Lizmap : les services
---------------------------------------------

.. image:: media/lwc_modifier_services.png
   :align: center

Configuration Lizmap : les répertoires
----------------------------------------

Pour chaque répertoire Lizmap sont listés

* *Les informations principales* : nom (label) et chemin (path)
* *La liste des droits* avec les groupes concernés
* *Des boutons d'action* : 
 
  - *voir* : affiche la page qui liste les cartes de ce répertoire
  - *Modifier*: affiche le formulaire de modification du répertoire
  - *Supprimer* : permet de supprimer le répertoire
  - *Vider le cache* : permet de supprimer tout le cache de toutes les couches des projets de ce répertoire
  
On peut créer un nouveau répertoire avec le bouton *Ajouter un répertoire* situé tout en bas de la page

Configuration Lizmap : les répertoires
---------------------------------------------

.. image:: media/lwc_infos_repertoire.png
   :align: center


Configuration Lizmap : ajouter un répertoire
---------------------------------------------

Pour créer un répertoire, il faut donner

* *un identifiant*: un mot sans espaces, accents ni caractères spéciaux
* *un label* : le nom qui sera affiché pour ce répertoire, accents et espaces autorisés
* *un chemin (path)* : le chemin complet vers le dossier qui contient les projets QGIS et les données

...

Configuration Lizmap : ajouter un répertoire
---------------------------------------------

...et définir les droits pour chaque groupe

* *Voir les répertoires* : 

  - tous les utilisateurs des groupes cochés pourront accéder aux cartes de ce répertoire
  - le groupe *anonymous* représente les utilisateurs non enregistrés et permet de rendre les cartes publiques


Configuration Lizmap : ajouter un répertoire
---------------------------------------------

.. image:: media/lwc_ajouter_repertoire.png
   :align: center


Configuration Lizmap : modifier un répertoire
---------------------------------------------

.. image:: media/lwc_modifier_repertoire.png
   :align: center


Fin
-----
