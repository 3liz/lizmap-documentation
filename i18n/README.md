Add local
============

* Add a directory for your langage
* Transform \*.pot files from the *pot* directory to \*.po files in your langage directory
* Translate the \*.po files with your favorite localize software

Update local
==============

```
cd source
sphinx-intl -l fr
```

* Translate the updated \*.po files with your favorite localize software

Build
=======

```
cd source
sphinx-intl build
cd ..
make -e BUILDDIR="../build/html/fr/" -e SPHINXOPTS="-D language='fr'" html
```
