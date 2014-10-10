===============================================================
Publier la carte par FTP
===============================================================

Rappel de l'architecture de Lizmap
===============================================================

.. image:: ../MEDIA/all-schema-client-server.png
   :align: center

**Lizmap repose sur le système de répertoires**. Pour publier une carte dans Lizmap, il suffit de s'assurer que le contenu du répertoire local contenant les données et les projets QGIS soit **reproduit exactement à l'identique** dans le répertoire du serveur correspondant. 

Pour cela, il faut donc **synchroniser le répertoire local avec celui du serveur** à chaque fois qu'on a mis à jour le projet QGIS, modifié la configuration Lizmap via le plugin, ou encore ajouté des fichiers dans le répertoire local.

.. note:: Si vous travaillez en local, que Lizmap-Web-Client est installé sur la même machine que celle que vous utilisez pour QGIS, vous n'avez pas besoin de FTP pour *synchroniser* vos dossiers. Cette configuration ne devrait exister que pour des tests.

.. note:: vous pouvez utiliser n'importe quel outil et protocole de synchronisation (FTP, FTPS, SFTP, rsync, unison, etc), mais il faut alors bien maîtriser les choses et avoir un accès à la configuration du serveur Lizmap


Utiliser un client FTP
===============================================================

Le protocole FTP permet d'accéder à des dossiers d'un serveur, d'y récupérer et d'y ajouter des documents et/ou dossiers. Il peut donc être utilisé pour synchroniser votre répoertoire local avec le répertoire du serveur sur lequel tourne Lizmap-Web-CLient. Ce protocole estun standard du Web qui peut-être exploité au travers de nombreux clients FTP.

Vous pouvez utiliser les clients suivants ou celui que vous avez l'habitude d'utiliser :

* *FireFTP* : Extension Firefox
* *Filezilla* : logiciel gratuit multi-plateforme (Windows, MacOS, Linux)
* *WinSCP* : logiciel gratuit pour Windows

Vous pouvez ces outils pour faire des modifications manuelles sur le répertoire distant :

* **faire un backup**
* **supprimer du contenu**
* **écraser les fichiers manuellement** : projet QGIS (.qgs) et configuration Lizmap (.qgs.cfg)


Utiliser l'onglet FTP de Lizmap
===============================================================

L'onglet FTP de Lizmap permet de configurer l'utilisation du protocole FTP directement dans QGIS. Afin de pouvoir faire une synchronisation en mode mirroir directement depuis le plugin. Pour intégrer la synchronisation FTP directement dans le plugin, nous nous sommes appuyés sur 2 outils libres qui ont fait leur preuve :

* **WinSCP** pour Windows: http://winscp.net/
* **lftp** pour Linux: http://lftp.yar.ru/ (anglais) et http://fr.wikipedia.org/wiki/Lftp
* Nous n'avons pas encore trouvé d'équivalent pour Mac OS (contributions bienvenues)

Pour pouvoir utiliser la synchronisation FTP depuis le plugin Lizmap, il faut installer un des clients FTP ci-dessus

* Sous Windows : WinSCP

 * Télécharger la **version portable**: http://winscp.net/eng/download.php
 * **Décompresser dans un répertoire**: par exemple "C:\\winscp\\"
 * **Onglet FTP du plugin** : indiquer le répertoire dans lequel vous avez décompressé le ZIP via le bouton "..."
 
* Sous linux : LFTP

.. code-block:: bash

   sudo apt-get install lftp # sous debian ou ubuntu. Remplacer par l'équivalent

Dans l'onglet FTP, vous configurer les paramètres suivants :

* **Hôte** : l'hôte FTP, correspondant au serveur sur lequel Qgis server et Lizmap Web sont installés (adresse IP ou nom de domaine)
* **Port** : le port FTP, 21 par défaut
* **Utilisateur** = l'utilisateur FTP
* **Mot de passe** = le mot de passe FTP
* **Répertoire distant** = chemin du répertoire dans lequel les projets Qgis sont stockés sur le serveur, relativement à la racine de votre accès FTP. Par exemple : /qgis/public/
* **Répertoire local** : rappel du chemin complet vers le projet QGIS

.. note:: Attention à bien vérifier la configuration avec l'administrateur du serveur sur lequel est installé Lizmap avant de faire vos tests !
