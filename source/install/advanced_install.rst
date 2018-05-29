===============================================================
Advanced installation configuration
===============================================================

Lizmap behind a proxy/reverse proxy
===================================

Sometimes, some URL in Lizmap may not what you wanted. For example, there
are using the "http" protocol instead of the "https" protocol. Or it may content
an unwanted port ( ``http://mydomain:5468/`` instead of ``http://mydomain/`` ).
Or url may not contain the real domain name.

In most of case, this is because the web server or PHP-fpm is behind a master
web server (which act as a proxy or reverse proxy), and then environment parameters
given by PHP or the backend web server to Lizmap are wrong.

You can tell to Lizmap to force to HTTPS, to use the right domain or to use the right port.

In ``localconfig.ini.php``, you can use these following configuration parameters.


To force to use the port 80 (true) or the 8080 for example with the http protocol:

.. code-block:: ini

    forceHTTPPort = true
    # or
    forceHTTPPort = 8080

To force to use the port 443 (true) or the 8443 for example with the https protocol:

.. code-block:: ini

    forceHTTPSPort = true
    # or
    forceHTTPPort = 8443

To specify the domain name of your lizmap application, if Lizmap cannot guess it:

.. code-block:: ini

    domainName = www.example.com


If the URL path of the backend web server does not correspond to the URL path
of the frontal web server (ex: the proxy redirects urls like
``http://example.com/index.php`` to your web server ``http://backend.example.com/foo/bar/index.php``,
You have to indicate the "public" URL path (basePath) and the backend URL Path (backendBasePath):

.. code-block:: ini

    [urlengine]
    basePath= /
    backendBasePath = /foo/bar

If the reverse proxy redirect HTTPS request to HTTP, you must deactivate the HTTPS check:

.. code-block:: ini

    [urlengine]
    checkHttpsOnParsing = off

Starting with Lizmap 3.0.18 and 3.1.6, you can indicate to force all generated
URL with the HTTPS protocol, when Lizmap doesn't know what is the protocol used
by requests on the reverse proxy:

.. code-block:: ini

    [urlengine]
    checkHttpsOnParsing = off
    forceProxyProtocol = https


Using environment variables
===========================

If some credentials or parameters are available in environment variables,
you can indicate use them into the ``localconfig.ini.php`` or ``profiles.ini.php`` files.
Be sure the environment variables are available to the PHP-FPM process or the APACHE/NGINX process.

Into this files, use the syntax ``${VARIABLE_NAME}``.

For example, to indicate postgresql credentials stored into these variables :

.. code-block:: bash

    LIZMAP_PGSQL_HOST=localhost
    LIZMAP_PGSQL_DATABASE=lizmap
    LIZMAP_PGSQL_LOGIN=admin
    LIZMAP_PGSQL_PASSWORD="Sup3Rp4ssw0rd!"

You write this configuration into profiles.ini.php:

.. code-block:: ini

   [jdb:jauth]
   driver="pgsql"
   database=${LIZMAP_PGSQL_DATABASE}
   host=${LIZMAP_PGSQL_HOST}
   user=${LIZMAP_PGSQL_LOGIN}
   password=${LIZMAP_PGSQL_PASSWORD}



