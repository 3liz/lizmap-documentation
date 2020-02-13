=======================================
Installing Lizmap Web Client on Windows
=======================================

This documentation shows the necessary steps to install Lizmap Web Client on a **Windows 7** and **Windows 10** environment. The other versions of Windows should not be a problem.

.. note:: In this document, the *version 3.3* of Lizmap Web Client is used. Be sure to adjust it according to the version you want to install (the later is recommended).

.. _requirements-label:

Requirements
------------

* Text Editor (e.g. `Notepad++ <https://notepad-plus-plus.org/>`_ , `Visual Studio Code <https://code.visualstudio.com/>`_ )
* Microsoft Visual C++ Redistributable 64-bits (this installation need to respect the compiling version of Apache and PHP) ( `Microsoft VCs C++ <https://support.microsoft.com/pt-pt/help/2977003/the-latest-supported-visual-c-downloads>`_ )
* Web Server (`Apache 24 64-bits <https://www.apachelounge.com/download>`_ )
* PHP 7.3.10 (`Non Thread Safe <https://windows.php.net/download/>`_ )
* QGIS Server 3 64-bits (`OSGeo4W Network Installer (64 bit) <https://download.osgeo.org/osgeo4w/osgeo4w-setup-x86_64.exe>`_)
* Lizmap Web Client 3.x (`Github Lizmap releases <https://github.com/3liz/lizmap-web-client>`_ )
* FTP software (e.g. `Filezilla <https://filezilla-project.org/>`_ , `WinSCP <https://winscp.net/eng/download.php>`_ ) 64-bits (*optional*)

Apache 2.4.41 Server Configuration
----------------------------------

Start with the creation of a folder near to **C:\\** (e.g. **C:\\webserver**). After that, download the Apache 64 bits and their modules. At the time of this documentation, we use the **VC16 compiled version**.

.. note:: You can use others installations of Apache but you need to be careful and install the correct the Microsoft Visual C++ Redistributables (e.g. VC15, VC16) and their modules for a correct Apache installation.

Extract the Apache24 zip file into **C:\\webserver\\** and change the name from **httpd-2.4.41-win64-VS16** to **Apache24**. After that unzip all modules and copy all *.so* files into the folder **C:\\webserver\\Apache24\\modules**.
Then you open the Apache configuration in **C:\\webserver\\Apache24\\conf\\httpd.conf** and edit with the text editor and replace the global variable *ServerRoot* to **C:\\webserver\\Apache24**. This action will allow Apache to recognize the path of Apache installation.

.. code-block:: apache

  Define SRVROOT "c:/webserver/Apache24" #Variable to define the root folder
  ServerRoot "${SRVROOT}"

The purpose of using the variable *SRVROOT* is the automatic replace of ${SRVROOT} to recognize the path that you define in the rest of the file. Now t's time to see what port is "*listen*" by the Apache. By default, Apache uses the **port 80**.

.. note:: If another port is to be used e.g. **1664**, add **Listen** option to the Apache **httpd.conf** file:

  .. code-block:: apache

    Listen 80 #Activated Default Apache port
    #Listen 1664 Example port if default Apache port is taken

    #You can activate or deactivate the ports using the # symbol

After choosing the port, is time to activate the Apache modules in the configuration file. For this action, you need
to change the Apache configuration in **C:\\webserver\\Apache24\\conf\\httpd.conf** and enable the modules that you need. Search for
**LoadModule** command lines and then uncheck ( remove :kbd:`#`) of the following modules:

.. code-block:: apache

  LoadModule fcgid_module modules/mod_fcgid.so
  LoadModule actions_module modules/mod_actions.so
  LoadModule ssl_module modules/mod_ssl.so
  LoadModule rewrite_module modules/mod_rewrite.so
  LoadModule headers_module modules/mod_headers.so
  LoadModule deflate_module modules/mod_deflate.so
  LoadModule expires_module expires_module modules/mod_expires.so
  LoadModule ext_filter_module modules/mod_ext_filter.so
  LoadModule ident_module modules/mod_ident.so

.. note:: If it’s necessary to use a different port then is necessary to active other modules associated with the **proxy module**:

  .. code-block:: apache

    LoadModule proxy_module modules/mod_proxy.so
    LoadModule proxy_http_module modules/mod_proxy_http.so
    LoadModule proxy_connect_module modules/mod_proxy_connect.so
    LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so
    LoadModule cache_module modules/mod_cache.so
    LoadModule cache_disk_module modules/mod_cache_disk.so

After this replacements, search with :kbd:`Ctrl+F` by the variable **ServerName** and add below the following words **ServerName localhost**. Continuing in this file will appear the **DirectoryIndex index.html**, please replace with **DirectoryIndex index.html index.php** after this action  **save** the file.

Start Apache opening the command line with :kbd:`Windows+R`, type :kbd:`cmd` and in the command line write **C:\\webserver\\Apache24\\bin\\httpd.exe** and don't close the :kbd:`cmd`.

.. warning:: It is important to **RIGHT-CLICK** in command line and “Run as administrator” to have complete access. Do it every time you need to use the *CMD*.


Pressing *Enter* after the instruction in the command line will result in a dialogue of windows firewall where is need to check the option **Allow Access For all**.

Using a browser, write http://localhost and press enter, if everything went right in installation this will open the page with the text **"It Works"**.

.. warning:: If don't popup the firewall windows this means that you probably have an anti-virus software managing your firewall. In this case, you need to check the configurations and allow manually the
   apache service. Another important tip is that if Windows Firewall doesn't show the previous dialog you need to add manually the port 80 as an inbound/outbound port in Advanced Windows Firewall properties ( :kbd:`Control Planel > Administrative Tools > Windows Firewall with Advanced Security` ).

Open the :kbd:`cmd` where you run the previous command to start Apache and press :kbd:`Ctrl+C` to stop Apache. To add the Apache in Windows System Path and have access directly in the :kbd:`cmd` it's necessary hold the :kbd:`Windows` and search for Edit System environments. After clicking in the result will appear a dialog with :kbd:`Environment Variables`. The next step is to append (not replace!) **;C:\\webserver\\Apache24\\bin** to the *Path* variable (double-click in "Path" line). After this step, close :kbd:`cmd` , reopen :kbd:`cmd` and check Apache is correctly declare in the *System path*. For this test, open :kbd:`cmd` type :kbd:`httpd` then hit enter this will run Apache, if Yes stop using the combination keys :kbd:`Ctrl+C`.

Now it's time to add Apache as Service, for this step you need to open the command line and type :kbd:`httpd -k install`. This will start Apache as a Windows Service.


After test with success the Apache installation, it's time to add the rest of Apache configurations that will serve the QGIS Server and the Lizmap Web Client. Open again the configuration file **C:\\webserver\Apache24\\httpd.conf** and add the following lines at the end of the file:

.. code-block:: apache

  <IfModule mod_deflate.c>
    SetOutputFilter DEFLATE
    BrowserMatch ^Mozilla/4 gzip-only-text/html
    BrowserMatch ^Mozilla/4\\.0[678] no-gzip
    BrowserMatch \\bMSIE !no-gzip !gzip-only-text/html
    SetEnvIfNoCase Request_URI \\.(?:gif|jpe?g|png|rar|zip)$ no-gzip dont-vary
    Header append Vary User-Agent env=!dont-vary
  </IfModule>

This configuration is important to deal with the files compression. After this configuration restart the Apache in the Windows command line using the following command :kbd:`httpd -k restart` and press Enter to receive the new configuration.
Now is time to prepare the configurations that will serve the php version. Start with a creation of an Apache configuration file to use the PHP configuration in **C:\\webserver\\Apache24\\conf\\extra\\** with the name of :kbd:`php73.conf`. This can be done if you open a text editor (e.g. Notepad++, Visual Studio Code, etc) and save it with the following code:

.. code-block:: apache

  FcgidInitialEnv PHPRC "C:\webserver\php73"
   <FilesMatch \.php$>
    AddHandler fcgid-script .php
    FcgidWrapper "C:/webserver/php73/php-cgi.exe" .php
   </FilesMatch>


   FcgidInitialEnv PHPRC "C:\\webserver\\php73"

   FcgidInitialEnv PATH "C:\OSGeo4W64\bin;C:\OSGeo4W64\apps\qgis-ltr\bin;C:\OSGeo4W64\apps\Qt5\bin;C:\OSGeo4W64\apps\grass\grass-6.4.3\lib;C:\OSGeo4W64\apps\grass\grass-6.4.3\bin;C:\Windows\system32;C:\Windows;C:\Windows\System32\WBem"
   FcgidInitialEnv QT_PLUGIN_PATH "C:\OSGeo4W64\apps\qgis-ltr\qtplugins;C:\OSGeo4W64\apps\Qt5\plugins"
   FcgidInitialEnv PYTHONHOME "C:\OSGeo4W64\apps\Python37"
   FcgidInitialEnv PYTHONPATH "C:\OSGeo4W64\apps\qgis-ltr\.\python;C:\OSGeo4W64\apps\qgis-ltr\.\python\plugins;C:\OSGeo4W64\apps\Python37\DLLs;C:\OSGeo4W64\apps\Python37\lib;C:\OSGeo4W64\bin;C:\OSGeo4W64\apps\Python37;C:\OSGeo4W64\apps\Python37\lib\site-packages"

   FcgidInitialEnv QGIS_SERVER_LOG_LEVEL 0
   FcgidInitialEnv QGIS_SERVER_LOG_FILE "C:\webserver\Apache24\logs\qgis_server.log"

   FcgidIOTimeout 120
   FcgidInitialEnv LC_ALL "en_US.UTF-8"
   FcgidInitialEnv PYTHONIOENCODING UTF-8
   FcgidInitialEnv LANG "en_US.UTF-8"
   FcgidInitialEnv QGIS_DEBUG 1
   FcgidInitialEnv QGIS_SERVER_LOG_FILE "C:\webserver\Apache24\logs\qgis_server.log"
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
    FcgidWrapper "C:/webserver/php73/php-cgi.exe" .php
   </FilesMatch>


.. note:: Make sure that you have the extension :kbd:`.conf` in this file.

Go to the file **C:\\webserver\\Apache24\\conf\\httpd.conf** and uncomment the line **Include conf\\extra\\httpd-vhosts.conf** and save the file. This action will allow to use our virtual hosts configurations in the file **C:\\webserver\\Apache24\\conf\\extra\\httpd-vhosts.conf**.
Include the vhosts to create the new virtual hosts configurations in the file **C:\\webserver\\Apache24\\conf\\extra\\httpd-vhosts.conf**. You can comment or delete the two examples inside (approximately between lines 23 and 38). If you add the comment in the default examples, copy and paste the next configurations after (the comment or deleted previous parts):

.. code-block:: apache

  <VirtualHost *:80>
    Include conf/extra/php73.conf #include the diretory conf file for php73 configuration
    ServerName localhost # name of the server, in this case is localhost

    DocumentRoot "C:/webserver/lizmap/" #Path to the root document Directory
    <Directory "C:/webserver/lizmap">
        Options -Indexes +FollowSymLinks +ExecCGI
        AllowOverride All
        Require all granted
    </Directory>

    CustomLog "logs/lizmap-access.log" common
    ErrorLog "logs/lizmap-error.log"

    <IfModule mod_fcgid.c>
		  RewriteEngine on
		  RewriteCond %{HTTP:Authorization} .
		  RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]
    </IfModule>

    #Parameters for maximum requests and timeout connections of fgci module
	  <IfModule fcgid_module>
		  FcgidMaxRequestLen 51200000
		  FcgidConnectTimeout 60
    </IfModule>

  </VirtualHost>

After this step save the file.

.. warning:: The previous configuration will help us to check if apache is correctly configurated. The same file will be use to increment the rest of addition along te installation. In the :ref:`preparation-lizmap` Section this configuration will be changed to receive two environments.

php 7.3.10 Configuration
------------------------

.. warning:: Lizmap web client is based on Jelix PHP framework. You must install at least the **7** version of PHP for full features. The **dom**, **simplexml**, **pcre**, **session**, **tokenizer** and **spl** extensions are required (they are generally turned on in a standard PHP 7.x installation)

For this installation we use the PHP 7.3.10, if you install the previouly the Microsoft Visual C++ Redistributable for Apache version of this documentation, you don't need to install again.
Go to `PHP binaries <https://windows.php.net/download/>`_ and download the link with the name **Zip**, **make sure** it is the non-thread-safe file.

After download create a folder in **C:\\webserver\\** with name php73 and unzip the files into it. Go to the file **C:\\webserver\\php73\\php.ini-production** and change into **C:\\webserver\\php73\\php.ini**.
Open the :kbd:`php.ini` and search for extension dir directive and change to the properly locate of **EXT** folder, make sure that you enter the full path like this **extension_dir = "C:\\webserver\\php73\\ext"**.
Now is time to activate the php modules, for this task you need to uncomment the following lines:

.. code-block:: ini

    extension=php_curl.dll
    extension=php_fileinfo.dll
    extension=php_gd2.dll
    extension=php_mbstring.dll
    ; driver for PostgreSQL
    extension=php_pdo_pgsql.dll
    ; driver for SQLite
    extension=php_pdo_sqlite.dll
    ; driver for PostgreSQL
    extension=php_pgsql.dll
    ; driver for SQLite3
    extension=php_sqlite3.dll

After the activation of the php extensions, in the same file change the upload values from default value to 15M and will stay like :kbd:`upload_max_filesize = 15M`. Please, do the same for post_max_size and change from default value to :kbd:`post_max_size = 15M` and save the changes in the file. Before you close this file,
create a folder with the name *sessions* in **C:\\webserver** and add the following path:

.. code-block:: ini

   ; The path can be defined as:
   ;
   session.save_path = "C:\webserver\sessions"
   ;


Add the PHP to your Windows System Path allowing to you call the apache directly in the :kbd:`cmd`. For this task, you hold the :kbd:`Windows` key and press :kbd:`Pause`. Then, click in *Advanced System Settings* and then in :kbd:`Environment Variables`. The next step is to append (not replace!) the path **;C:\\webserver\\php-7.3** to the *Path* variable (double-click in "Path" line). After this step, close :kbd:`cmd` , reopen :kbd:`cmd` and check PHP is correctly declare in the *System path* using :kbd:`cmd` and typing :kbd:`php -m`
You will check now the Apache configuration with :kbd:`httpd -S`.

Create a folder with the name lizmap inside of **C:\\webserver\\lizmap** add a file with .php extension and save with this code inside of file:

.. code-block:: php


  <?php phpinfo(); ?>

Restart Apache in command line with :kbd:`httpd -k restart` and see if everything is right. If YES, open the browser and type http://localhost/index.php and will appear the page of PHP properties we assume that you install correctly the PHP.



QGIS Server Installation
------------------------

Go to https://www.qgis.org/en/site and get the file `Osgeo4W Network installer (64 bit) <https://download.osgeo.org/osgeo4w/osgeo4w-setup-x86_64.exe>`_ and run the installer. Choose the following options:

1. Advanced Installer;
2. Install from internet;
3. Root Directory **C:\\OSGeo4W64** and install for **all users**;
4. Keep default Local Package Directory and Start Menu Name;
5. Do not configure proxy if not needed;
6. Choose a download site (e.g. https://download.osgeo.org );
7. Select packages : command line_Utilities/gdal, Desktop/Qgis full , Web/Qgis server, lib/fcgi  then Next (We use for stable purposes, the QGIS LTR version);
8. Accept to get packages to meet dependencies : Next then Wait for the download to be completed and Agree to all licenses.

.. note:: This process can be long (~ 1 hour).

After the installation we need to configure QGIS Server to be accessible as fcgi, so you need to modify the previous file of virtual hosts in the directory  **C:\\webserver\\Apache24\\conf\\extra\\httpd-vhosts.conf** to have this content:

.. code-block:: apache

  <VirtualHost *:80>
    Include conf/extra/php73.conf
    ServerName localhost # name of the server, in this case is localhost

    DocumentRoot "C:/webserver/lizmap/" #Path to the root document Directory
    <Directory "C:/webserver/lizmap">
        Options -Indexes +FollowSymLinks +ExecCGI
        AllowOverride All
        Require all granted
    </Directory>

    # Added QGIS Server Folder
    Alias /qgis/ "C:/OSGeo4W64/apps/qgis-ltr/bin/"
    <Directory "C:/OSGeo4W64/apps/qgis-ltr/bin/">
        SetHandler fcgid-script
        Options +ExecCGI
        AllowOverride All
        Require all granted
    </Directory>

    CustomLog "logs/lizmap-access.log" common
    ErrorLog "logs/lizmap-error.log"

    <IfModule mod_fcgid.c>
		  RewriteEngine on
		  RewriteCond %{HTTP:Authorization} .
		  RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]
    </IfModule>

    #Parameters for maximum requests and timeout connections of fgci module
	  <IfModule fcgid_module>
      FcgidMaxRequestLen 51200000
      FcgidConnectTimeout 60
    </IfModule>

  </VirtualHost>

After the changes restart apache, type in command line the instruction:

.. code-block:: winbatch

   httpd -k restart


Now it's time to test the QGIS Server and see if is accessible in fcgi typing in the browser the following link: http://localhost/qgis/qgis_mapserv.fcgi.exe and if everything is right you will receive the following response:

.. code-block:: xml

   <ServiceExceptionReport version="1.3.0">
      ServiceException code="OperationNotSupported">Please check the value of the REQUEST parameter</ServiceException>
   </ServiceExceptionReport>

.. _preparation-lizmap:

Preparing the home of Lizmap Web Client
---------------------------------------

Is usefull to have 2 environments, one for production and other for preproduction (or master to test new features), for this action you will need to create the folders **C:\\webserver\\lizmap\\prod\\** and  **C:\\webserver\\lizmap\\preprod\\** and change the Apache VirtualHost configuration file.

First, go to 3Liz `Github repository tags <https://github.com/3liz/lizmap-web-client/tags>`_ and get the last version in ZIP format. For example, you can use `Lizmap-web-client 3.4 <https://github.com/3liz/lizmap-web-client/releases/download/3.3.4/lizmap-web-client-3.3.4.zip>`_ for prod folder and the `master version <https://github.com/3liz/lizmap-web-client/archive/master.zip>`_ for predprod folder.

Each environment will have a version in parallel. For example: release_3_3 and master. For that you need to unzip in **C:\\webserver\\lizmap\\prod** the release_3_3 version and **C:\\webserver\\lizmap\\preprod** the master version.
Then you can create a directory where you will put the tile cache for production environment **C:\\webserver\\cache\\prod** and for master environment **C:\\webserver\\cache\\preprod**.
After create the cache folders, modify the virtual host to point to the **www folders** of lizmap web client application for each environment. Go to the file  **C:\\webserver\\Apache24\\conf\\extra\\httpd-vhosts.conf** and change to the following configuration:

.. code-block:: apache

    # example configuration in httpd-vhosts.conf
    <VirtualHost *:80>
    Include conf/extra/php73.conf
    ServerName localhost

    # Lizmap Production
    # Version 3_3
    Alias /webgis/ "C:/webserver/lizmap/prod/release_3_3/lizmap/www/"
    <Directory "C:/webserver/lizmap/prod/release_3_3/lizmap/www">
        Options -Indexes +FollowSymLinks +ExecCGI
        AllowOverride All
        Require all granted
    </Directory>

    # Lizmap Pre-production (master)
    # Version master
    Alias /preprod/ "C:/webserver/lizmap/preprod/master/lizmap/www/"
    <Directory "C:/webserver/lizmap/preprod/master/lizmap/www">
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

    # ABP: needed for authentication in Lizmap
    <IfModule mod_fcgid.c>
        RewriteEngine on
        RewriteCond %{HTTP:Authorization} .
        RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]
    </IfModule>

    <IfModule fcgid_module>
        FcgidMaxRequestLen 51200000
        FcgidConnectTimeout 60
    </IfModule>

    </VirtualHost>



After the replacement save the file and restart Apache with the command line instruction:

.. code-block:: winbatch

  httpd -k restart

In case of lizmap version >= 3.0, you must use some scripts to install it properly (see https://github.com/3liz/lizmap-web-client/blob/master/INSTALL.md ). Open the command line (:kbd:`cmd.exe`) and write the next instructions:

.. code-block:: bat

   REM Production folder
   cd C:\webserver\lizmap\prod\release_3_3\
   cd lizmap\var\config
   copy lizmapConfig.ini.php.dist lizmapConfig.ini.php
   copy localconfig.ini.php.dist localconfig.ini.php
   copy profiles.ini.php.dist profiles.ini.php
   cd ..\..\..

.. code-block:: bat

  REM PreProd (Master) folder
  cd C:\webserver\lizmap\preprod\master\
  cd lizmap\var\config
  copy lizmapConfig.ini.php.dist lizmapConfig.ini.php
  copy localconfig.ini.php.dist localconfig.ini.php
  copy profiles.ini.php.dist profiles.ini.php
  cd ..\..\..

If you want to enable the demo repositories in both environments, before this installation you need to add to the file **localconfig.ini.php** in both environments the following code:

.. code-block:: ini

  [modules]
  lizmap.installparam=demo


Using PostgreSQL as administrator database (Optional)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. note:: **Requirements**: PostgreSQL/PostGIS installation

By default, when you install Lizmap Web Client, you will install a sqlite database where will be store the information about users, permissions among other information.

Imagine that you are GIS Manager and you want to link the user and password credentials of lizmap to the PostgreSQL users and password credentials.

For that before of LWC installation you need to change the file :kbd:`profiles.ini.php` in the folder of both environments in the folder **C:\\webserver\\lizmap\\prod\\release_3_3\\lizmap\\var\\config (Production Folder)**  and **C:\\webserver\\lizmap\\preprod\\master\\lizmap\\var\\config (PreProduction Folder)** with the following lines:

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


After all your previous changes you are ready to launch the installer of lizmap for both environments in the command line (:kbd:`cmd`):

.. code-block:: bat

   REM Production Lizmap
   cd C:\webserver\lizmap\prod\release_3_3\
   php lizmap\install\installer.php

.. code-block:: bat

   REM PreProduction Lizmap
   cd C:\webserver\lizmap\prod\master\
   php lizmap\install\installer.php


Configuring the Lizmap Admin Panel
------------------------------------

**[PROD] Production Environment** ( `webgis <http://localhost//webgis//index.php>`_ )

After the correct installation owith the installer, go to http://localhost/webgis/index.php and you should see the Lizmap application home page with the demo project Montpellier - Transport.
Now it's time to configure the Lizmap Admin Panel, go to http://localhost/webgis/admin.php and do the login with:

* **user=admin**;
* **password=admin**;

Then for security proposes change the admin password, for example: **lizmap_12345**. If it makes sense, you can delete the users lizadmin and logintranet.
You can do the same for groups, in this case delete group Intranet Demo Group and Lizadmin group.

Go to Lizmap configuration menu > Delete the "intranet" repository (at the bottom). Then you need to change the **URL WMS Server**, go to Lizmap configuration menu / Edit the Services form and change the WMS Server URL from: http://127.0.0.1/cgi-bin/qgis_mapserv.fcgi to http://localhost/qgis/qgis_mapserv.fcgi.exe
After that, also change the cache directory from  **C:\\Windows\\Temp\\** to: **C:\\webserver\\cache\\prod\\** and save this configuration.

Now check the Montpellier demo project is working: http://localhost/webgis/index.php/view/map/?repository=montpellier&project=montpellier

**[PREPROD] Pré-production Environment** ( `preprod <http://localhost//preprod//index.php>`_ )

After the correct installation with the installer, go to http://localhost/preprod/index.php and you should see the Lizmap application home page with the demo project Montpellier - Transport.
Now it's time to configure the Lizmap Admin Panel, go to http://localhost/preprod/admin.php and do the login with:

* **user=admin**;
* **password=admin**;

Then for security proposes change the admin password, for example: **lizmap_12345**. If it makes sense, you can delete the users lizadmin and logintranet. You can do the same for groups, in this case delete group Intranet Demo Group and Lizadmin group.

Go to Lizmap configuration menu > Delete the "intranet" repository (at the bottom). Then you need to change the **URL WMS Server**, go to Lizmap configuration menu > Edit the Services form and change the WMS Server URL from: http://127.0.0.1/cgi-bin/qgis_mapserv.fcgi to http://localhost/qgis/qgis_mapserv.fcgi.exe
After that, also change the cache directory from  **C:\\Windows\\Temp\\** to: **C:\\webserver\\cache\\preprod\\** and save this configuration.

Now check the Montpellier demo project is working: http://localhost/preprod/index.php/view/map/?repository=montpellier&project=montpellier

Lizmap directories configuration
--------------------------------

You need to create a Lizmap directory architecture for organization porposes. Create the following directories via a :kbd:`*.bat` file ( Please Check line ends are correct, you can open using notepad, notepad++):

.. code-block:: winbatch

   REM common folder for both environments
   mkdir C:\webserver\data\common\
   REM common folder to publish SVG and images files in QGIS Server
   mkdir C:\webserver\data\document\

   REM directory of prod data
   mkdir C:\webserver\data\prod\
   REM common folder between rep in production environment
   mkdir C:\webserver\data\prod\common\
   mkdir C:\webserver\data\prod\rep1\
   mkdir C:\webserver\data\prod\rep1\media\
   mkdir C:\webserver\data\prod\rep1\media\js\
   mkdir C:\webserver\data\prod\rep2\
   mkdir C:\webserver\data\prod\rep2\media\
   mkdir C:\webserver\data\prod\rep2\media\js\

   REM directory of preprod data
   mkdir C:\webserver\data\preprod\
   REM common folder between rep in preprod (master) environment
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

In Apache you need to Add a vhost to publish SVG and images files via HTTP this will avoid the bug in QGIS Server under Windows which cannot display SVG icon when you have a relative path. Previous your create a folder **C:\\webserver\\data\\document\\** and now is necessary to modify the file **C:\\webserver\\Apache24\\conf\\extra\\httpd-vhosts.conf**, adding the following directory:

.. code-block:: apache

    #Add this configuration before of the two environments directories.
    Alias /document/ "C:/webserver/data/document/"
    <Directory "C:/webserver/Data/document">
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>


After this step save and restart Apache. Please check if you can add svg file in a folder, for example **C:\\webserver\\Data\\document\\svg\\my_icon.svg** and then access it via *http://localhost/webgis/document/svg/my_icon.svg* and use it as the SVG path in the style properties of a vector layer.



FTP Server Configuration (e.g. Filezilla)
-----------------------------------------
This configuration only applies if your using a remote server.

Now you will configure a FTP to have a remote access and deploy in a easy way into the server the qgis projects and their project elements.
First you need to download `server FTP <https://filezilla-project.org/download.php?type=server>`_. Then install the default configuration in the server.

.. note:: Do not forget to **"Execute with admin rights"**

1. Specify the **Port: 14147** .
2. Open the FileZilla Server Interface trough  Windows Menu > All programs > FileZilla Server > FileZilla Server Interface and click **OK** to connect (no password required yet).
3. Modify some options via Menu Edit > Settings and change IP Filter if needed : to filter only some IP, use **"*"** in the first block, the add the mask in the second block.
4. Passive mode settings > Use following IP : write your public IP and change port range : **5500-5700**.
5. Logging: Enable logging to file, and limit log file size to **500 KB**.
6. SSL/TLS settings : Enable FTP over SSL/TLS && Generate new certificate into **C:\\webserver\\cert\\ftp_certificate.crt** && Allow explicit FTP over TLS && Disallow plain unencrypted FTP && Leave **port 990**.
7. Autoban - Enable with default values.
8. Create user: Edit > Users - button Add **user= lizmap_user** and **pass= choose_a_password**
9. Shared folder (Access to **PROD** and **PREPROD** Environment): Add **C:\\webserver\\lizmap** - Give all rights by checking checkboxes for Files and Directories.
10. You can add IP filter here too if needed.

After the remote configuration, in the workstation of the GIS manager you can reproduce the structure of folders to be exactly of the remote to help the management of the folder. After that,
is necessary install a FTP client see :ref:`requirements-label` section. Another thing, is it's necessary a client certificate produced by the remote in the GIS manager. After that try to connect with:
**Server** = Remote IP. Use Passive mode AND check IPV6.

.. note:: You can see this tutorial (only in french): https://forum.hardware.fr/hfr/WindowsSoftware/Tutoriels/filezilla-serveur-securise-sujet_300273_1.htm

