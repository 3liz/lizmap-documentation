===============================================================
Installing Lizmap Web CLient on Windows
===============================================================

This documentation shows the progress of the installation Lizmap Web Client on a Windows 7 environment. The other versions of Windows should not be a problem. To facilitate installation, we use the OSGeo4W software, which allows to install all the necessary components in a centralized manner.

.. warning:: The Apache version provided by OSGeo4W is out of date. This documentation has to be updated.

.. note:: In this document, the version 2.10.3 of Lizmap Web Client is used. Be sure to adapt it according to the version you want to install (the latter is recommended).

Install
===============================================================

1. Download OSGeo4W on the QGIS download page

http://qgis.org/fr/site/forusers/download.html

2. Launch the OSGeo4W installer and choose the Advanced Installation

.. image:: /images/installation-osgeo4w-01.jpg
   :align: center

3. Use the internet facility

.. image:: /images/installation-osgeo4w-02.jpg
   :align: center

4. Select the root for OSGeo4W elements installation and prefer the accessibility option to all users

.. image:: /images/installation-osgeo4w-03.jpg
   :align: center

5. Select the root of local packages

.. image:: /images/installation-osgeo4w-04.jpg
   :align: center

6. Specify the type of Internet connection (with a proxy or not)

.. image:: /images/installation-osgeo4w-05.jpg
   :align: center

7. Select in 'Desktop' the package 'QGIS-full'

.. image:: /images/installation-osgeo4w-06.jpg
   :align: center

8. Select in 'Web' the package 'QGIS-server'

.. image:: /images/installation-osgeo4w-07.jpg
   :align: center

9. Select in 'Lib' the package 'fcgi'

.. image:: /images/installation-osgeo4w-08.jpg
   :align: center

10. Initiate and complete the installation

At this point all that is necessary to LizMap Web Client is installed on the machine.
The next steps are to configure the server, install and configure LizMap Web Client.

11. Apache checking

To verify that the server is well installed, open in the browser the url: http://localhost

If nothing appears this is that the installation was not successful.

12. PHP checking

Click on the link 'phpinfo' on the home page of the OSGeo4W Apache server. This page allows you to check the configuration of your server. You should find information about cgi-fcgi, PDO and PDO_SQLITE but not CURL or GD which depends LizMap Web Client.

.. image:: /images/installation-osgeo4w-09.jpg
   :align: center

.. image:: /images/installation-osgeo4w-10.jpg
   :align: center

13. Activate CURL and GD2

Open the file C:\OSGeo4W\bin\PHP.ini and uncomment extensions curl and gd2

.. image:: /images/installation-osgeo4w-11.jpg
   :align: center

14. Restart Apache

Changing the file C:\OSGeo4W\bin\PHP.ini to activate CURL and GD into PHP CURL, requires to restart the Apache server. To do this :

* click in the main menu of windows on the monitor apache 'All programs > OSGeo4W > Apache > OSGeo4W-Apache-Monitor'.

  .. image:: /images/installation-osgeo4w-12.png
     :align: center

* Click on the apache monitor that is among the hidden icons in the task bar (bottom right) and 'Restart'.

  .. image:: /images/installation-osgeo4w-13.png
     :align: center

16. Check CURL and GD

In the web browser, reload the page 'phpinfo'. You should find a CURL and GD section.

.. image:: /images/installation-osgeo4w-14.jpg
   :align: center

17. Download LizMap Web Client

The Lizmap Web Client code is free and downloadable from github. To download the latest version:

* Go to https://github.com/3liz/lizmap-web-client/tags
* Click on the small *zip* link of the latest version.
* Cliquez sur le petit lien *zip* de la dernière version. For example the following link for 2.10.3 version: https://github.com/3liz/lizmap-web-client/archive/2.10.3.zip

18. Unzip LizMap Web Client in 'C:\\OSGeo4W\\apache\\htdocs\\lizmap\\'

You should now have a folder 'C:\\OSGeo4W\\apache\\htdocs\\lizmap\\lizmap-web-client-2.10.3\\'

19. Test Lizmap Web Client Installation


Test if LizMap Web Client is well installed by opening in the browser the link: http://localhost/lizmap/lizmap-web-client-2.10.3/lizmap/www. You should see displayed the project "Montpellier" supplied with LizMap Web Client and set to be visible to all. To view maps, it is necessary to configure LizMap Web Client.

20. Administration Interface

Go to the address http://localhost/lizmap/lizmap-web-client-2.10.3/lizmap/www/admin.php and connect with the login / password: 'admin/admin'.

.. note:: 
If authentication does not work check that the directory 'C:\\OSGeo4W\\tmp' exists.

21. Edit QGIS Server URL

* Click on 'LizMap config' and then modify in the Services section to specify the url of your QGIS-Server.

* Replace the url of WMS server by http://127.0.0.1/qgis/qgis_mapserv.fcgi.exe and record:

.. image:: /images/installation-osgeo4w-17.jpg
   :align: center

23. Check

To ensure that the configuration was successful, click on 'Project List' above. You should have access to two maps since you are authenticated as administrator. Click on one of the maps. If the configuration is good you should view the map, and thus be in possession of a Lizmap Web Client ready for yours.


Add Spatialite support to PHP
==============================================================

To use the editing tool on Spatialite layers, it is necessary to add the spatialite extension to PHP. Unfortunately, it requires a PHP version of at least 5.3 to do it, and for now, the installer OSGeo4W offers only 5.2.

*It is therefore not possible at this time under Windows with the apache server from the OSGeo4W installer to use Spatialite layers for editing.*

Lizmap Web Client tests whether the Spatialite support is enabled in PHP. If it is not, then the Spatialite layers will not be used in the editing tool. You can always use PostgreSQL data instead.
