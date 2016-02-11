Lizmap - Documentation
=======================

This repository contains the complete documentation of the Lizmap application to publish online QGIS maps: the QGIS plugin and Lizmap Web Client application.

This documentation uses **Sphinx** (http://sphinx-doc.org) and its internationalization mechanism (http://sphinx-doc.org/intl.html):
* **source** contains the documentation in \*.rst format
* **i18n** contains the locals

Contribution
=============

* Update documentation by updating **source** files
* Localize documentation by updating your langage in **i18n** or adding ones.

Update localized files
=======================

* Update pot files from source files

```
sphinx-build -b gettext source i18n/pot
```

* Update localized files

```
sphinx-intl update -d i18n
```

Build documentation
====================

```
# Generate .mo files ( build from .po )
sphinx-intl build -d i18n

# Build default HTML documentation, default is english version
sphinx-build -b html source/ build/html/en/

# Build french HTML documentation
sphinx-build -b html -D language='fr' source/ build/html/fr/
# Replace fr for other languages
```
