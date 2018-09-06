Lizmap - Documentation
=======================

This repository contains the complete documentation of the Lizmap application to 
publish online QGIS maps: the QGIS plugin and Lizmap Web Client application.

This documentation uses **Sphinx** (http://sphinx-doc.org) and its 
internationalization mechanism (http://sphinx-doc.org/intl.html):
* **source** contains the documentation in \*.rst format
* **i18n** contains the locales

Contribution
=============

You can use Transifex: https://www.transifex.com/3liz-1/lizmap-documentation/

Or:

* Update documentation by updating **source** files
* Localize documentation by updating your langage in **i18n** or adding ones.

Update localized files
=======================

* Update pot files from source files

```
make gettext
```

* Update localized files (*.po)

```
sphinx-intl update -d i18n
```

Then you can improve po files by opening them with QtLinguist or Poedit.

Build documentation
===================

We advise to use the **make** command to build Sphinx documentation. By default,
`make html` will build the docs in all available languages.
