Documentation for core contributors
===================================

Installing Transifex cli and Sphinx
------------------------------------

We are using Transifex, and so you will need their cli tool to push or pull
translations.

It is recommended to install Sphinx into a dedicated Python environment. For example:

```
python3 -m venv .venv
.venv/bin/pip install -r requirements.txt
``` 

To install Transifex, see https://developers.transifex.com/docs/cli.
For linux, the fastest way:

```
cd /tmp; \
curl -L "https://github.com/transifex/cli/releases/latest/download/tx-linux-amd64.tar.gz" | tar xz --skip-old-files; \
sudo mv tx /usr/local/bin/tx
```

You should create a `~/.transifexrc` file containing:

```
[https://www.transifex.com]
api_hostname = https://api.transifex.com
hostname = https://www.transifex.com
rest_hostname = https://rest.api.transifex.com
username = api
password = 
token
```

In the password parameter and in the token parameter, you should set an API Key [you have to generate from your
Transifex account](https://www.transifex.com/user/settings/api/).

Updating the list of strings to translate
-----------------------------------------

You must first generate the `.pot` files, from the `.rst` files:

```
make gettext
```

Then you push them to Transifex

```
./push_to_transifex.sh
```

Updating translated strings
---------------------------

It is not recommended to modify by hand files into `i18n/`! We prefer to 
translate strings into Transifex.

To retrieve translated string:

```
./update_from_transifex.sh
```

You can then commit them.

Adding a new language
----------------------

The language should be created into Transifex. When there are enough translated
strings, you can download translated files with `tx pull`. See above.
Update the list of available language into the Makefile file (in the TRANSLATIONS variable).

Releasing a new version of Lizmap 
---------------------------------

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
