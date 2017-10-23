=======================================
Installing Lizmap Web Client on Windows
=======================================
This documentation shows the progress of the installation Lizmap Web Client on a Windows 10 environment. The other versions of Windows should not be a problem.

.. note:: In this document, the version 3.0 of Lizmap Web Client is used. Be sure to adapt it according to the version you want to install (the latter is recommended).

Apache 2.x.x Server Configuration
---------------------------------

First we create a folder near to **C:\\** . For example, **C:\\webserver\\** . After that, we need to download the Apache 64 bits, compiled with VC11, for example: http://www.apachelounge.com/download/VC11/binaries/httpd-2.4.20-win64-VC11.zip.

.. note:: You can use another installations http://www.apachelounge.com/download/VC11/

Extract the zip file inside **C:\\webserver\\** and change the name from **httpd-2.4.20-win64-VC11** to **Apache24**.
Then you open the Apache configuration in **C:\\webserver\\Apache24\\conf\\httpd.conf** and edit with a text editor (e.g. Notepad++ or Notepad) and replace all occurrences of **C:/Apache24** into **C:/webserver/Apache24**.

After this replacement, search with :kbd:`Ctrl+F` by the variable **ServerName** and add below the following words **ServerName localhost**. If you continue in this file, you will find **"DirectoryIndex index.html"** and then replace with **DirectoryIndex index.html index.php** and **save** the file.

To see if the Apache can start, open the command-line with :kbd:`Windows+R` and type :kbd:`cmd`, then in the shell write **C:\\webserver\\Apache24\\bin\\httpd.exe** and don't close the :kbd:`cmd`.

.. warning:: It is important to **RIGHT-CLICK** and *"Run as administrator"* to have complete access. Do it every time you need to use the *Shell*.


After you type the instruction click enter and you will see a notice of windows firewall and you need to **Allow Access For all**.
Then open the browser and write http://localhost and press enter this will open the page with the **"It Works"**.

.. warning:: If don't popup  the firewall windows this means that you probably have an anti-virus software managing your firewall. In this case, you need to check the configurations and allow manually the apache service. Another import tip if Windows Firewall don't show the previous dialog you need to add manually the port 80 as inbound/outbound port in Advanced Windows Firewall properties (Control Planel>Administrative Tools>Windows Firewall with Advanced Security).

Open the :kbd:`cmd` where you run the previous command and press :kbd:`Ctrl+C` to stop Apache. Then add the Apache to your Windows System Path allowing to you call the apache directly in the :kbd:`cmd`. So for this task, you hold the :kbd:`Windows` and press :kbd:`Pause`. Then, click in *Advanced System Settings* and then in :kbd:`Environment Variables`. The next step is to append (not replace!) **;C:\\webserver\\Apache24\\bin** to the *Path* variable (double-click in "Path" line). After this step, close :kbd:`cmd` , reopen :kbd:`cmd` and check Apache is correctly declare in the *System path*. In :kbd:`cmd` type :kbd:`httpd` then hit enter this will run Apache, if Yes you can stop pressing :kbd:`Ctrl+C`.

Now it's time to add Apache as Service, for this step you need to open the command line and type :kbd:`httpd -k install`. This will start Apache as a Windows Service.

After you have the Apache configured as Service you will need the mod_fgci module that can be found in http://www.apachelounge.com/download/VC11/modules/modules-2.4-win64-VC11.zip .

.. note:: You can use anothers installations http://www.apachelounge.com/download/VC11/

The link above include several apache modules, unzip the file **mod_fcgid-2.3.9\mod_fcgid\mod_fcgid.so** into the directory **C:\\webserver\\Apache24\\modules\\**. After this you need to change the Apache configuration in **C:\\webserver\\Apache24\\conf\\httpd.conf** and enable the modules that you need. Search for **LoadModule** command lines and the line **LoadModule fcgid_module modules/mod_fcgid.so**. In the added LoadModule line please uncheck ( remove :kbd:`#`) the following modules: **mod_actions.so**, **mod_ssl.so**, **mod_rewrite.so**, **mod_headers.so**, **mod_deflate.so**, **mod_expires.so**, **mod_ext_filter.so**, **mod_ident.so**. This action will activate them.

.. note:: If you need to use a different port, it's necessary active others modules associated to proxy : **proxy**, **proxy_http**, **proxy-connect**, **proxy-fcgin cache**, **disk-cache**, **headers**

You need to configure the files compression, so you need to add the following lines at the end of the :kbd:`httpd` configuration file:

.. code-block:: apache

  <IfModule mod_deflate.c>
    SetOutputFilter DEFLATE
    BrowserMatch ^Mozilla/4 gzip-only-text/html
    BrowserMatch ^Mozilla/4\\.0[678] no-gzip
    BrowserMatch \\bMSIE !no-gzip !gzip-only-text/html
    SetEnvIfNoCase Request_URI \\.(?:gif|jpe?g|png|rar|zip)$ no-gzip dont-vary
    Header append Vary User-Agent env=!dont-vary
  </IfModule>

.. note:: If another port is to be used e.g. **1664**, add **Listen** option to the Apache **httpd.conf** file:
   Listen 80
   Listen 1664

After this restart the Apache use the command-line and type :kbd:`httpd -k restart` .


php 5.x.xx Configuration
------------------------

.. warning:: Lizmap web client is based on Jelix 1.6. You must install at least the **5.4** version of PHP. The **dom**, **simplexml**, **pcre**, **session**, **tokenizer** and **spl** extensions are required (they are generally turned on in a standard PHP 5.4 installation)

Go to http://windows.php.net/download/ and download php-5.6.23-Win32-VC11-x64.zip , make sure it is the non-thread-safe file, for example:
http://windows.php.net/downloads/releases/php-5.6.23-Win32-VC11-x64.zip

After download unzip in **C:\\webserver\\php-5.6.23** and go to the file **C:\\webserver\\php-5.6.23\\php.ini-production** and change into **C:\\webserver\\php-5.6.23\\php.ini**.
Open the :kbd:`php.ini` and search for extension dir directive and change to the properly locate of **EXT** folder, make sure that you enter the full path like this **extension_dir = "C:\\webserver\\php-5.6.23\\ext"**.
Now is time to activate the php modules, for this task you need to uncommeting the following lines:

.. code-block:: ini

    extension=php_curl.dll
    extension=php_fileinfo.dll
    extension=php_gd2.dll
    extension=php_mbstring.dll
    extension=php_pdo_pgsql.dll
    extension=php_pdo_sqlite.dll
    extension=php_pgsql.dll
    extension=php_sqlite3.dll

Then you need to change the upload values from deafult value to 15M and will stay like :kbd:`upload_max_filesize = 15M`. Do the same for post_max_size and change from default value to 15M like this :kbd:`post_max_size = 15M`. After this changes save the file.
Add the PHP to your Windows System Path allowing to you call the apache directly in the :kbd:`cmd`. So for this task, you hold the :kbd:`Windows` and press :kbd:`Pause`. Then, click in *Advanced System Settings* and then in :kbd:`Environment Variables`. The next step is to append (not replace!) **;C:\\webserver\\php-5.6.23** to the *Path* variable (double-click in "Path" line). After this step, close :kbd:`cmd` , reopen :kbd:`cmd` and check PHP is correctly declare in the *System path*. In :kbd:`cmd` type :kbd:`php -m`
You will check now the Apache configuration with :kbd:`httpd -S`

After this steps and you need to create a configuration file for using of PHP, so you need to create a file in **C:/webserver/Apache24/conf/extra/** with the name of :kbd:`php-5.6.23.conf`. This can be done if you open a text editor and save it with the following code:

.. code-block:: apache

  FcgidInitialEnv PHPRC "C:\\webserver\\php-5.6.23"
   <FilesMatch \\.php$>
    AddHandler fcgid-script .php
    FcgidWrapper "C:/webserver/php-5.6.23/php-cgi.exe" .php
   </FilesMatch>


.. note:: Make sure that you have the extension :kbd:`.conf` in this file.

Go to :kbd:`http.conf` and uncomment the line :kbd:`Include conf/extra/httpd-vhosts.conf` . This will permit you add new virtual hosts in the file **C:/webserver/Apache24/conf/extra/httpd-vhosts.conf**. After this change save the file.
You need to create the new virtual host, so open the file **C:/webserver/Apache24/conf/extra/httpd-vhosts.conf** and comment or delete the two examples inside (approximately between lines 23 and 38). If you add the comment in the default examples, copy and paste this configurations after the default configurations:

.. code-block:: apache

  <VirtualHost *:80>
    Include conf/extra/php-5.6.23.conf
    ServerName localhost
    DocumentRoot "C:/webserver/lizmap/"

    <Directory "C:/webserver/lizmap">
        Options -Indexes +FollowSymLinks +ExecCGI
        AllowOverride All
        Require all granted
    </Directory>

    CustomLog "logs/lizmap-access.log" common
    ErrorLog "logs/lizmap-error.log"
  </VirtualHost>

After this step save the file.
Create a folder with the name lizmap inside **C:/webserver** and in the **C:/webserver/lizmap** add a file with PHP extension and save with this code inside of file:

.. code-block:: php


   php <?php phpinfo(); ?>

Restart Apache in command line with :kbd:`httpd -k restart` and see if everything is right. If YES, open the browser and type http://localhost/index.php and will appear the page of PHP properties we assume that you install correctly the PHP.

.. note:: for the PostgreSQL drivers PHP extensions you need to have them **installed**.

QGIS Server Installation
------------------------

Go to http://www.qgis.org and get the file **Osgeo4W Network installer (64 bit)** (e.g. http://download.osgeo.org/osgeo4w/osgeo4w-setup-x86_64.exe ) and run the installer. Choose the following options:

1. Advanced Installer;
2. Install from internet;
3. Root Directory **C:\\OSGeo4W64** and install for **all users**;
4. Keep default Local Package Directory and Start Menu Name
5. Do not configure proxy if not needed
6. Choose a download site : click on http://download.osgeo.org the "Next"
7. Select packages : Commandline_Utilities/gdal, Desktop/Qgis full , Web/Qgis server, lib/fcgi  then Next (We use for stable purposes, the QGIS LTR version)
8. Accept to get packages to meet dependencies : Next then Wait for the download to be completed and Agree to all licenses

.. note:: This process can be long (~ 1 hour).

After the installation we need to configure QGIS Server to be accessible as fcgi, so you need to modify the file in the directory  **C:/webserver/Apache24/conf/extra/httpd-vhosts.conf** to have this content:

.. code-block:: apache

    <VirtualHost *:80>
    Include conf/extra/php-5.6.23.conf
    ServerName localhost

    # Lizmap Production
    DocumentRoot "C:/webserver/lizmap/prod/"
    <Directory "C:/webserver/lizmap/prod">
        Options -Indexes +FollowSymLinks +ExecCGI
        AllowOverride All
        Require all granted
    </Directory>

    # LizMap Pré-production
    Alias /preprod/ "C:/webserver/lizmap/preprod/"
    <Directory "C:/webserver/lizmap/preprod">
        Options -Indexes +FollowSymLinks +ExecCGI
        AllowOverride All
        Require all granted
    </Directory>

    Alias /qgis/ "C:/OSGeo4W64/apps/qgis-ltr/bin/"
    <Directory "C:/OSGeo4W64/apps/qgis-ltr/bin/">
        SetHandler fcgid-script
        Options +ExecCGI
        AllowOverride All
        Require all granted
    </Directory>

    CustomLog "logs/lizmap-access.log" common
    ErrorLog "logs/lizmap-error.log"
    </VirtualHost>

After this modification go to the file **C:\\webserver\\Apache24\\conf\\extra\\php5.6.23.conf** and modify it as well to have the next configuration:

.. code-block:: apache

  FcgidInitialEnv PHPRC "C:\\webserver\\php-5.6.23"

  FcgidInitialEnv PATH "C:\OSGeo4W64\bin;C:\OSGeo4W64\apps\qgis-ltr\bin;C:\OSGeo4W64\apps\grass\grass-6.4.3\lib;C:\OSGeo4W64\apps\grass\grass-6.4.3\bin;C:\Windows\system32;C:\Windows;C:\Windows\System32\WBem"
   FcgidInitialEnv QT_PLUGIN_PATH "C:\OSGeo4W64\apps\qgis-ltr\qtplugins;C:\OSGeo4W64\apps\Qt4\plugins"
   FcgidInitialEnv PYTHONHOME "C:\OSGeo4W64\apps\Python27"
   FcgidInitialEnv PYTHONPATH "C:\OSGeo4W64\apps\qgis-ltr\.\python;C:\OSGeo4W64\apps\qgis-ltr\.\python\plugins;C:\OSGeo4W64\apps\Python27\DLLs;C:\OSGeo4W64\apps\Python27\lib;C:\OSGeo4W64\bin;C:\OSGeo4W64\apps\Python27;C:\OSGeo4W64\apps\Python27\lib\site-packages"

  FcgidInitialEnv QGIS_SERVER_LOG_LEVEL 0
  FcgidInitialEnv QGIS_SERVER_LOG_FILE "C:\\webserver\\Apache24\\logs\\qgis_server.log"

  FcgidIOTimeout 120
        FcgidInitialEnv LC_ALL "en_US.UTF-8"
        FcgidInitialEnv PYTHONIOENCODING UTF-8
        FcgidInitialEnv LANG "en_US.UTF-8"
        FcgidInitialEnv QGIS_DEBUG 1
        FcgidInitialEnv QGIS_SERVER_LOG_FILE "C:\\webserver\Apache24\logs\\qgis_server.log"
        FcgidInitialEnv QGIS_SERVER_LOG_LEVEL 0
        FcgidInitialEnv QGIS_PLUGINPATH "C:\OSGeo4W64\apps\qgis-ltr\python\plugins"

  SetEnvIf Request_URI ^/qgis QGIS_PREFIX_PATH "C:\OSGeo4W64\apps\qgis-ltr"
  SetEnvIf Request_URI ^/qgis TEMP "C:\Windows\Temp"

  SetEnvIf Request_URI ^/qgis GDAL_DATA "C:\OSGeo4W64\share\gdal"
  SetEnvIf Request_URI ^/qgis GDAL_DRIVER_PATH "C:\OSGeo4W64\bin"
  SetEnvIf Request_URI ^/qgis PDAL_DRIVER_PATH "C:\OSGeo4W64\bin"
  SetEnvIf Request_URI ^/qgis GDAL_SKIP "JP2ECW"
  SetEnvIf Request_URI ^/qgis PROJ_LIB "C:\OSGeo4W64\share\proj"

   <FilesMatch \.php$>
    AddHandler fcgid-script .php
    FcgidWrapper "C:/webserver/php-5.6.23/php-cgi.exe" .php
   </FilesMatch>


After the changes restart apache, type in commandline the instruction:

.. code-block:: winbatch

   httpd -k restart


Now it's time to test the QGIS Server and see if is accessible in fcgi, for this you nee to type in the browser the link: http://localhost/qgis/qgis_mapserv.fcgi.exe and if everything is right you will receive the following response:

.. code-block:: xml

   <ServiceExceptionReport version="1.3.0">
     ServiceException code="OperationNotSupported">Please check the value of the REQUEST parameter</ServiceException>
   </ServiceExceptionReport>

Preparing the home of LizMap Web Client
---------------------------------------

Now you will install 2 environments, one for production and other for preproduction, for this action you need to create in the following folders:
**C:\\webserver\\lizmap\\prod\\** and  **C:\\webserver\\lizmap\\preprod\\**

Go to 3Liz Github repository https://github.com/3liz/lizmap-web-client/tags and get the last version in ZIP format. For example, you can use 3.0 (
**https://codeload.github.com/3liz/lizmap-web-client/zip/release_3_0.zip**) or for master version (**https://github.com/3liz/lizmap-web-client/archive/master.zip**).

Each environment will have several versions in parallel. For example: master and release_3_0. For that you need to unzip in **C:\\webserver\\lizmap** to have at the end a folder (example give for production and master version environment) **C:\\webserver\\lizmap\\prod\\master\\**
Then create a directory where you will put the tile cache in prod **C:/webserver/cache/prod** and for preprod **C:/webserver/cache/preprod**.

After create the cache folders, modify the virtual host to point to the **www folder** of lizmap web client application. Got to the file  **C:/webserver/Apache24/conf/extra/httpd-vhosts.conf** and replace for the example: **C:/webserver/lizmap** by **C:/webserver/lizmap/prod/master/lizmap/www** .

.. code-block:: apache

    # example configuration in httpd-vhosts.conf
    <VirtualHost *:80>
    Include conf/extra/php5.6.23.conf
    ServerName localhost

    # Lizmap Production
    # Version master
    DocumentRoot "C:/webserver/lizmap/prod/master/lizmap/www/"
    <Directory "C:/webserver/lizmap/prod/master/lizmap/www/">
        Options -Indexes +FollowSymLinks +ExecCGI
        AllowOverride All
        Require all granted
    </Directory>

    # LizMap Pré-production
    # Version master used
    Alias /preprod/ "C:/webserver/lizmap/preprod/master/lizmap/www/"
    <Directory "C:/webserver/lizmap/preprod/master/lizmap/www/">
        Options -Indexes +FollowSymLinks +ExecCGI
        AllowOverride All
        Require all granted
    </Directory>

    Alias /qgis/ "C:/OSGeo4W64/apps/qgis-ltr/bin/"
    <Directory "C:/OSGeo4W64/apps/qgis-ltr/bin/">
        SetHandler fcgid-script
        Options +ExecCGI
        AllowOverride All
        Require all granted
    </Directory>

    # ABP: needed for authentication in Lizmap
    <IfModule mod_fcgid.c>
        RewriteEngine on
        RewriteCond %{HTTP:Authorization} .
        RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]
    </IfModule>

    CustomLog "logs/lizmap-access.log" common
    ErrorLog "logs/lizmap-error.log"
    </VirtualHost>

After the replacement save the file and restart Apache with the command-line instruction:

.. code-block:: winbatch

  httpd -k restart

In case of lizmap version >= 3.0, you must use some scripts to install it properly (see https://github.com/3liz/lizmap-web-client/blob/master/INSTALL.md ). Open the command-line (:kbd:`cmd.exe`) and write the next instructions:

.. code-block:: bat

   cd C:\webserver\lizmap\prod\master\
   cd lizmap\var\config
   copy lizmapConfig.ini.php.dist lizmapConfig.ini.php
   copy localconfig.ini.php.dist localconfig.ini.php
   copy profiles.ini.php.dist profiles.ini.php
   cd ..\..\..

If you want to enable the demo repositories, just add to localconfig.ini.php the following code:

.. code-block:: ini

  [modules]
  lizmap.installparam=demo

And then you can launch the installer in the command-line (:kbd:`cmd`):

.. code-block:: bat

   cd C:\webserver\lizmap\prod\master\
   php lizmap\install\installer.php

Using PostgreSQL as administrator database (Optional)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. note:: **Requirements**: PostgreSQL/PostGIS installation

By default, when you install LizMap Web Client, you will install a sqlite database where will be store the information about users, permissions among other information.

Imagine that you are GIS Manager and you want to link the user and password credentials of lizmap to the PostgreSQL users and password credentials.

For that before the installation you need to change the file :kbd:`profiles.ini.php` in the folder **C:\\webserver\\lizmap\\lizmap-web-client-master\\lizmap\\var\\config** with the following lines:

.. code-block:: ini

   default=jauth
   jacl2_profile=jauth

Add :kbd:`;` to deactivate the sqlite database.

.. code-block:: ini

   ;[jdb:jauth]
   ;driver=sqlite3
   ;database="var:db/jauth.db"

   ;[jdb:lizlog]
   ;driver=sqlite3
   ;database="var:db/logs.db"
   ; when you have charset issues, enable force_encoding so the connection will be
   ; made with the charset indicated in jelix config
   ;force_encoding = on

   ; with the following parameter, you can specify a table prefix which will be
   ; applied to DAOs automatically. For manual jDb requests, please use method
   ; jDbConnection::prefixTable().
   ;table_prefix =

Remove :kbd:`;` and fill with PostgreSQL credentials:

.. code-block:: ini

   ;Example of different driver (e.g PostgreSQL)
   [jdb:jauth]
   driver="pgsql"
   database="name_of_database"
   host="localhost"
   user="Admin_user_postgreSQL"
   password="put_here_the_password"

   [jdb:lizlog]
   driver="pgsql"
   database="name_of_database"
   host="localhost"
   user="Admin_user_postgreSQL"
   password="put_here_the_password"


   ; Example for pdo (eg. MySQL):
   ;driver=pdo
   ;dsn=mysql:host=your_host;dbname=name_of_database
   ;user=
   ;password=


Configurating the LizMap Admin Panel
------------------------------------

After the correct installation with the installer, go to http://localhost/index.php and you sould see the Lizmap application home page with the demo project Montpellier - Transport. Now it's time to configure the LizMap Admin Panel, go to http://localhost/admin.php and do the login with **user=admin** and **password=admin**.
Then for security proposes change the admin password, for example: **lizmap_12345**. If you want so, you can delete the users lizadmin and logintranet. You can do the same for groups, in this case delete group Intranet Demo Group and Lizadmin group.
Go to Lizmap configuration menu / Delete the "intranet" repository (at the bottom). Then you need to change the **URL WMS Server**, go to Lizmap configuration menu / Edit the Services form and change the WMS Server URL from: http://127.0.0.1/cgi-bin/qgis_mapserv.fcgi to http://localhost/qgis/qgis_mapserv.fcgi.exe
After that, also change the cache directory from  **C:/Windows/Temp/** to: **C:/webserver/cache/** and save this configuration.
Now check the Montpellier demo project is working: http://localhost/index.php/view/map/?repository=montpellier&project=montpellier


LizMap directories configuration
--------------------------------

You need to create a Lizmap directory architecture for organization porposes. Create the following directories via a :kbd:`*.bat` file ( Please Check line ends are correct, you can open using notepad and not notepad++):

.. code-block:: winbatch

   mkdir C:\webserver\data\common\
   mkdir C:\webserver\data\document\
   mkdir C:\webserver\data\prod\
   mkdir C:\webserver\data\prod\common\
   mkdir C:\webserver\data\prod\rep1\
   mkdir C:\webserver\data\prod\rep1\media\
   mkdir C:\webserver\data\prod\rep1\media\js\
   mkdir C:\webserver\data\prod\rep2\
   mkdir C:\webserver\data\prod\rep2\media\
   mkdir C:\webserver\data\prod\rep2\media\js\
   mkdir C:\webserver\data\preprod
   mkdir C:\webserver\data\preprod\common\
   mkdir C:\webserver\data\preprod\rep1\
   mkdir C:\webserver\data\preprod\rep1\media\
   mkdir C:\webserver\data\preprod\rep1\media\js\
   mkdir C:\webserver\data\preprod\rep2\
   mkdir C:\webserver\data\preprod\rep2\media\
   mkdir C:\webserver\data\preprod\rep2\media\js\


Now we need to get access to the folder **C:\\webserver\\data\\prod** and its subfolders so that the GIS admin can send the QGIS project files, the Lizmap configuration file for each project, the GIS data into these folders and other documents. Go to Lizmap administration panel in http://localhost/admin.php and create the new repository. Follow this steps:

* Lizmap configuration / Create a new repository (button at the bottom of the page)
* **id** = rep1
* **label** = A repository label (you will be able to change it afterwards)
* **path** = /webserver/data/prod/rep1/

.. note:: IMPORTANT FOR THE REPOSITORY PATH -> DO NOT USE: **C:\\webserver\\data\\prod\\rep1**

In Apache you need to Add a vhost to publish SVG and images files via HTTP this will avoid the bug in QGIS Server under Windows which cannot display SVG icon when you have a relative path. Create a folder **D:/webserver/data/document/** and modify the file **C:/webserver/Apache24/conf/extra/httpd-vhosts.conf** .
Please add these lines before CustomLog:

.. code-block:: apache

    Alias /document/ "C:/webserver/data/document/"
    <Directory "C:/webserver/Data/document">
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>


After this step save and restart Apache. Please check if you can add svg file in the folder C:/webserver/Data/document/svg/, for example C:/webserver/Data/document/svg/my_icon.svg and then access it via http://localhost/document/svg/my_icon.svg and use it as the SVG path in the style properties of a vector layer.



Filezilla Server Configuration
------------------------------

Now you will configure a FTP to have a rmeote access and deploy in a easy way into the server the qgis projects and their project elements.
First you need to download at https://filezilla-project.org/download.php?type=server. Then install the default configuration.

.. note:: Do not forget to **"Execute with admin rights"**

1. Specify the **Port: 14147** .
2. Open the FileZilla Server Interface trough  Windows Menu / All programs / FileZilla Server / FileZilla Server Interface and click **OK** to connect (no password required yet).
3. Modify some options via Menu Edit / Settings and change IP Filter if needed : to filter only some IP, use **"*"** in the first block, the add the mask in the second block.
4. Passive mode settings : Use following IP : write your public IP + change port range : **5500 5700**.
5. Logging: Enable logging to file, and limit log file size to **500 KB**.
6. SSL/TLS settings : Enable FTP over SSL/TLS && Generate new certificate into **C:\webserver\cert\ftp_certificate.crt** && Allow explicit FTP over TLS && Disallow plain unencrypted FTP && Leave **port 990**.
7. Autoban - Enable with default values.
8. Create user: Edit / Users - button Add **user= lizmap_user** and **pass= choose_a_password**
9. Shared folder: Add **D:\\webserver\\prod\\data** - Give all rights by checking checkboxes for Files and Directories.
10. You can add IP filter here too if needed.

Now you need to it, install FireFTP and restart Firefox. After that try to connect with:
**Server** = localhost . Use Passive mode AND check IPV6.

.. note:: You can see this tutorial (only in french): http://forum.hardware.fr/hfr/WindowsSoftware/Tutoriels/filezilla-serveur-securise-sujet_300273_1.htm

Now you need to set the PREPROD environment, for this you need to:

1. Copy **C:\\webserver\\lizmap\\prod** content into **C:\\webserver\\lizmap\\preprod** ;
2. Delete content of folder **C:\\webserver\\lizmap\\preprod\\master\\temp\\lizmap\\www\\** ;
3. Lauch admin web interface to configure preprod lizmap repositories: http://localhost/preprod/admin.php ;
4. In Lizmap / Configuration Lizmap / Services : Change "Cache root directory" into **C:\\webserver\\cache\\preprod**.
