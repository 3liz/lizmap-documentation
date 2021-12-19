# Documentation for core contributors

## RST substitutions

* Use RST substitutions : http://www.sphinx-doc.org/en/master/usage/restructuredtext/roles.html#default-substitutions
* Use Lizmap substitutions : check the file `substitutions.rst`

## Installing Transifex CLI and Sphinx

We are using Transifex, and so you will need their CLI tool to push or pull
translations.

It is recommended to install Virtualenv and to install Sphinx and 
Transifex into a dedicated Python environment. For example:

```
python3 -m venv .venv
.venv/bin/pip install requirements.txt
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

## Updating the list of strings to translate

You must first generate the `.pot` files, from the `.rst` files:

```
make gettext
```

Then you push them to Transifex, by indicating the branch (indicate the good branch name !!)

```
./push_to_transifex.sh
```

Note: our continuous integration system Gitlab-CI generates and pushes pot files to
Transifex at each commit.

## Updating translated strings

It is not recommended modifying by hand files into `i18n/`! We prefer to 
translate strings into Transifex.

To retrieve translated string:

```
./update_from_transifex.sh -f
```

You can then commit them.

Note: our continuous integration system regularly retrieves translated strings
to publish the web site. It doesn't rely on `.po` files stored into the repository.

## Adding a new language

The language should be created into Transifex. When there are enough translated
strings, you can download translated files with `tx pull`. See above.
Update the list of available language into :
* the `Makefile` file in the `TRANSLATIONS` variable.
* the `lizmap_versions.json` in the `locales` variable.
* the `update_from_transifex.sh` in `AVAILABLE_LOCALES` variable.
* the `.gitlab-ci.yml` in `retrieve_po_and_build` stage.

## Releasing a new version

When a new major version of lizmap has been released, be sure the documentation
is updated into the `master` branch.

When the documentation is ready to release `X.Y` from the master branch:

1. Set the version number into `source/conf.py` about `X.Y`, mainly the `release` without the suffix.
2. Update the file `source/lizmap_versions.json`
3. Update gitlab-ci about this new branch
4. Commit these 3 files : `Release version X.Y`
5. Create a new branch `git checkout -b lizmap_X_Y` (replace X and Y).
6. Configure a new schedule in the CI configuration for this new branch
7. On the master branch, set the next version into `source/conf.py` and `source/lizmap_versions.json`
8. Push the new branch and the master branch
9. In the server configuration, change the target of the symbolic link 'current'
10. Copy the `source/lizmap_versions.json` into all other branches, it should be the
    same for all.

## Archive an old version

1. Checkout the branch
1. `./update_from_transifex.sh -f
1. `git commit -am 'Archive LWC BRANCH translations, EOL'`
1. Remove all ressources on Transifex for the BRANCH
