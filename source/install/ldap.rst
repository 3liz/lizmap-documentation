====================
LDAP authentication
====================

The advantage of using LDAP is that all the users and groups information can be held on one server which is centrally managed.

The first thing to do is to install the php ldap extension on your linux system:

.. code-block:: bash

   apt install php8.4-ldap

Then, in order to enable the LDAP support Lizmap, you have to install a module that allows to authenticate with Ldap.

Note: in previous version (Lizmap 3.9 and lower), there was an embedded module named ldapdao. Since Lizmap 3.10, it does
not exists anymore, and is replaced by a new module, multiauth, you have to install.


Be sure PHP is installed, as weel as Composer (`apt install composer` in Debian, or install by hand from https://getcomposer.org ).

Installing the module
=====================

In ``lizmap/my-packages``, create the ``composer.json`` file if it does not exist yet (by copying ``composer.json.dist``).

Add the PHP package ``jelix/multiauth-module``:


.. code-block:: bash

    composer require jelix/multiauth-module


If you want an interface to setup the ldap configuration (recommended), add the package ``jelix/ldapadmin-module``:

.. code-block:: bash

    composer require jelix/ldapadmin-module


Then go into  the ``lizmap/install`` directory, and enable the modules into Lizmap:

.. code-block:: bash

    cd ../install/
    php configurator.php multiauth
    # and if you installed ldapadmin:
    php configurator.php ldapadmin

Finish the installation with:

.. code-block:: bash

    php installer.php


Configuring LDAP
================

There is already a configuration set into lizmap. See the `[ldap:lizmapldap]` section into your profiles.ini.php,
with some settings that allow to connect to your ldap server, and to search
users into the ldap. The default parameters are typical parameters to connect and search to an OpenLdap server.
Of course, they are just an example, and you have to modify them, according your Ldap structure.

.. code-block:: ini

    [ldap:lizmapldap]
    hostname=localhost
    port=389
    adminUserDn="cn=admin,ou=lizmap,dc=com"
    adminPassword=""
    searchUserBaseDN="dc=XY,dc=fr"
    searchUserFilter="(&(objectClass=posixAccount)(uid=%%LOGIN%%))"
    searchAttributes="uid:login,givenName:firstname,sn:lastname,mail:email,organization:organization,street:street,postcode:postcode,city:city"
    searchGroupFilter=
    searchGroupProperty="cn"
    searchGroupBaseDN=""

If you install ``ldapadmin``, you have a new menu entry in the administration page of Lizmap : "Ldap configuration".
It allows to edit and tests all of these parameters.

See details about how to set these parameters in a section below.

Configuration properties for user data
--------------------------------------

To verify password, or to register the user into Lizmap the first time he
authenticate himself, the plugin needs some data about the user.

You should indicate to it which ldap attributes it can retrieve, and which
database fields that will receive the ldap attributes values.

You indicate such informations into the `searchAttributes` property. It is a
pair of names, ``<ldap attribute>:<table field>``, separated by a comma.

In this example, ``searchAttributes="uid:login,firstname,sn:lastname,mail:email,dn:"``:

- the value of the `uid` ldap attribute will be stored into the `login` field
- the value of the `sn` ldap attribute will be stored into the `lastname` field
- the value of the `firstname` ldap attribute will be stored into a field that
  have the same name, as there is no field name nor ``:``.
- there will not be mapping for the `dn` property. There is a ``:`` without field name.
  It will be readed from ldap, and can be used into the `bindUserDN` DN template.
  (see below).

The list of possible fields in Lizmap are: `login`, `email`,  `firstname`,
`lastname`,  `organization`,  `phonenumber`, `street`, `postcode`, `city`,
`country`. Only  `login` and `email` are required. Others are optional.


Configuration properties for authentication
-------------------------------------------

Before to try to authenticate the user against the ldap, the plugin retrieves
user properties. It uses two configuration parameters : `searchUserFilter`
and `searchAttributes`.

The `searchUserFilter` should contain the ldap query, and a ``%%LOGIN%%`` placeholder
that will be replaced by the login given by the user.

Example: ``searchUserFilter="(&(objectClass=posixAccount)(uid=%%LOGIN%%))"``

You may also indicate the base DN for the search, into `searchUserBaseDN`. Example:
``searchUserBaseDN="ou=ADAM users,o=Microsoft,c=US"``.

Note that you can indicate several search filters, if you have
complex ldap structure. Use ``[]`` to indicate an item list:

.. code-block:: ini

    searchUserFilter[]="(&(objectClass=posixAccount)(uid=%%LOGIN%%))"
    searchUserFilter[]="(&(objectClass=posixAccount)(cn=%%LOGIN%%))"


To verify the password, the plugin needs the DN (Distinguished Name) corresponding
to the user. The ldap property containing the DN should be indicated into the `bindAttribute`. Its default value is ``dn``.


Configuration properties for user rights
----------------------------------------

If you have configured groups rights into Lizmap, and if these
groups match your ldap groups, you can indicate to the plugin to automatically
put the user into the application groups, according to the user ldap groups.

You should then indicate into `searchGroupFilter` the ldap query that will
retrieve the groups of the user.

Example: ``searchGroupFilter="(&(objectClass=posixGroup)(member=%%USERDN%%))"``

``%%USERDN%%`` is replaced by the user dn. ``%%LOGIN%%`` is replaced by the login.
You can also use any ldap attributes you indicate into `searchAttributes`,
between `%%`. Example: ``searchGroupFilter="(&(objectClass=posixGroup)(member=%%givenName%%))"``

Warning : setting `searchGroupFilter` will remove the user from any other
application groups that don't match the ldap group. If you don't want
a groups synchronization, leave `searchGroupFilter` empty.

With `searchGroupProperty`, you must indicate the ldap attribute that
contains the group name. Ex: ``searchGroupProperty="cn"``.

You may also indicate the base DN for the search, into `searchGroupBaseDN`. Example:
``searchGroupBaseDN="ou=Groups,dc=Acme,dc=pt"``.

Debugging
----------

If the authentication does not working, you can have more details on what is
wrong. To see these details, you should activate the traces for multiauth.

In your var/config/localconfig.ini.php, set these parameters

.. code-block:: ini

    [logger]
    auth=file

    [fileLogger]
    auth=auth.log

Then, in var/log/auth.log, you will have some messages from the ldap connector.
Remove these settings when you don't need them, to avoid a huge auth.log file.

