====================
LDAP authentication
====================

The advantage of using LDAP is that all the users and groups information can be held on one server which is centrally managed.

The first thing to do is to install the php ldap extension on your linux system:

.. code-block:: bash

   apt-get install php5.6-ldap

or

.. code-block:: bash

   apt-get install php7.x-ldap


Then, in order to enable the LDAP support Lizmap, you have to change the
authentication method in the configuration as follows.

Enabling ldap into Lizmap 3.2
==============================

In the localconfig.ini.php, you have to set these parameters:

.. code-block:: ini

    [modules]
    ldapdao.access=1

    [coordplugin_auth]
    driver=ldapdao

These parameters enable the ldapdao module of Lizmap. If you copied localconfig.ini.php
from localconfig.ini.php.dist, you have already this parameters but they are
commented.

Then you have to add a section `[ldap:lizmapldap]` into your profiles.ini.php,
with some settings that allow to connect to your ldap server, and to search
users into the ldap. The section may already exist if you copied profiles.ini.php
from the profiles.ini.php.dist.

.. code-block:: ini

    [ldap:lizmapldap]
    hostname=localhost
    port=389
    adminUserDn="cn=admin,ou=lizmap,dc=com"
    adminPassword=""
    searchUserBaseDN="dc=XY,dc=fr"
    searchUserFilter="(&(objectClass=posixAccount)(uid=%%LOGIN%%))"
    bindUserDN="uid=%?%,ou=users,dc=XY,dc=fr"
    searchAttributes="uid:login,givenName:firstname,sn:lastname,mail:email"
    searchGroupFilter=
    searchGroupProperty="cn"
    searchGroupBaseDN=""

See details about how to set these parameters in a section below.

.. note:: these parameters could be in the ldapdao section of auth.coord.ini.php
          configuration files, but it is not recommended to modify these files,
          as when you do upgrade, you should do modification again in them.

To finish to enable the module, run *php lizmap/install/installer.php*

Enabling ldap into Lizmap 3.0 and 3.1
======================================

Lizmap 3.2 embed the `ldaodao module <https://github.com/jelix/ldapdao-module>`_
but not Lizmap 3.0 and 3.1, so you should install it by hand.

So download it from https://github.com/jelix/ldapdao-module , and copy the ldapdao
directory into you lizmap/lizmap-modules/ directory (you should use at least
the 2.0.0 version)

Declare the ldapdao module into the *lizmap/var/config/localconfig.ini.php* file

.. code-block:: ini

   [modules]
   ldapdao.access=1

Check the following modules state into the *lizmap/var/config/mainconfig.ini.php* file

.. code-block:: ini

   [modules]
   ;...
   jacl2.access=1
   jauth.access=2
   jauthdb.access=1

Run *php lizmap/install/installer.php*

Run *lizmap/install/set_rights.sh www-data www-data*

Redefine the path of the authentication config file into the *lizmap/var/config/admin/config.ini.php*
and *lizmap/var/config/index/config.ini.php* files:

.. code-block:: ini

   [coordplugins]
   auth="authldap.coord.ini.php"


Create a profile like this according to your ldap settings into the *lizmap/var/config/profiles.ini.php* file

.. code-block:: ini

   [ldap:myldap]
   hostname=localhost
   port=389
   adminUserDn="cn=admin,ou=admins,dc=acme"
   adminPassword="Sup3rP4ssw0rd"
   searchUserBaseDN="dc=XY,dc=fr"
   searchUserFilter="(&(objectClass=posixAccount)(uid=%%LOGIN%%))"
   bindUserDN="uid=%?%,ou=users,dc=XY,dc=fr"
   searchAttributes="uid:login,givenName:firstname,sn:lastname,mail:email"
   searchGroupFilter=
   searchGroupProperty="cn"
   searchGroupBaseDN=""


Now you have to change these settings.


ldap settings
====================


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
to the user. It builds the DN from a "template" indicated into the `bindUserDN`
property, and from various data. These data can be the given login or one of
the ldap attributes of the user.

- *Building the DN from the login given by the user*: bindUserDN should contain
  a DN, with a ``%%LOGIN%%`` placeholder that will be replaced by the login.

  Example: ``bindUserDN="uid=%%LOGIN%%,ou=users,dc=XY,dc=fr"``. If the user
  give `john.smith` as a login, the authentication will be made with the DN
  ``bindUserDN="uid=john.smith,ou=users,dc=XY,dc=fr"``.

  For some LDAP, the DN could be a simple string, for example an email.
  You could then set ``bindUserDN="%%LOGIN%%@company.local"``. Or even
  ``bindUserDN="%%LOGIN%%"`` if the login can type the full value of
  the DN or an email or else.. (Probably it's not recommended to allow
  a user to type himself its full DN, it can be a security issue)

- *Building the DN from one of the ldap attributes of the user*.
  In this case, the plugin will first query the ldap directory with the
  `searchUserFilter` filter, to retrieve the user's ldap attributes.
  Then, in bindUserDN, you can indicate a DN where some values will be replaced
  by some attributes values, or you can indicate a single attribute name,
  corresponding to an attribute that contain the full DN of the user.

  For the first case, bindUserDn should contain a DN, with some ``%?%`` placeholders
  that will be replaced by corresponding attributes value. Example:
  ``bindUserDN="uid=%?%,ou=users,dc=XY,dc=fr"``. Here it replaces the ``%?%`` by the
  value of the `uid` attribute readed from the user's attributes.
  The attribute name should be present into the `searchAttributes`
  configuration property, even with no field mapping. Ex: ``...,uid:,...``. See above.

  For the second case, just indicate the attribute name, prefixed with a `$`.
  Example: ``bindUserDN="$dn"``. Here it takes the `dn` attribute readed from
  the search, and use its full value as the DN to login against the ldap server.
  It is useful for some LDAP server like sometimes Active Directory that need a
  full DN specific for each user.
  The attribute name should be present into the `searchAttributes`
  configuration property, even with no field mapping. Ex: ``...,dn:,...``. See above.

Note that you can indicate several dn templates, if you have
complex ldap structure. Use ``[]`` to indicate an item list:

.. code-block:: ini

    bindUserDN[]="uid=%?%,ou=users,dc=XY,dc=fr"
    bindUserDN[]="cn=%?%,ou=users,dc=XY,dc=fr"

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
wrong. To see these details, you should activate the traces for ldapdao.

In your var/config/localconfig.ini.php, set these parameters

.. code-block:: ini

    [logger]
    auth=file

    [fileLogger]
    auth=auth.log

Then, in var/log/auth.log, you will have some messages from the ldap connector.
Remove these settings when you don't need them, to avoid a huge auth.log file.

