Documentation for core contributors
===================================

Installing Transifex cli and Sphinx
------------------------------------

We are using Transifex, and so you will need their cli tool to push or pull
translations.

It is recommended to install Virtualenv and to install Sphinx and 
Transifex into a dedicated Python environnement. For exemple:

```
virtualenv env/
env/bin/pip install sphinx
env/bin/pip install sphinx-intl
env/bin/pip install transifex-client
``` 

You should create a `~/.transifexrc` file containing:

```
[https://www.transifex.com]
api_hostname = https://api.transifex.com
hostname = https://www.transifex.com
username = api
password = 
```

In the password parameter, you should set an API Key [you have to generate from your
Transifex account](https://www.transifex.com/user/settings/api/).

Updating the list of strings to translate
-----------------------------------------

You must first generate the `.pot` files, from the `.rst` files:

```
make gettext
```

Then you push them to Transifex, by indicating the branch (indicate the good branch name !!)

```
tx push -s --branch master
#or 
tx push -s --branch lizmap_3_1
```

Note: our continuous integration system Gitlab-CI generates and pushes pot files to
Transifex at each commit.

Updating translated strings
---------------------------

It is not recommended to modify by hand files into `i18n/`! We prefer to 
translate strings into Transifex.

To retrieve translated string:

```
tx pull -l es,fi,fr,it,pt,ru --branch master
#or 
tx pull -l es,fi,fr,it,pt,ru --branch lizmap_3_2
```

You can then commit them.

Note: our continuous integration system regularly retrieves translated strings
to publish the web site. It doesn't rely on `.po` files stored into the repository.

Adding a new language
----------------------

The language should be created into Transifex. When there are enough translated
strings, you can download translated files with `tx pull`. See above.
Update the list of available language into the Makefile file (in the TRANSLATIONS variable).

Releasing a new version 
------------------------

When a new major version of lizmap has been released, be sure the documentation
is updated into the master branch.

When the documentation is ready, 

- set the version number into source/conf.py 
- update the file source/lizmap_versions.json
- create a new branch `lizmap_X_Y` (replace X and Y).
- configure a new schedule in the CI configuration for this new branch
- on the master branch, set the next version into source/conf.py and source/lizmap_versions.json
- push the new branch and the master branch
- in the server configuration, change the target of the symbolic link 'current'
- copy the source/lizmap_versions.json into all other branches, it should be the
  same for all.






