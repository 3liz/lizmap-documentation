Lizmap - Documentation
=======================

This repository contains the complete documentation of the Lizmap application.

Lizmap allows to publish online QGIS maps.

The documentation is localized into several language. The main language is
the english. 

Contributing to the english documentation
=========================================

Clone the repository and edit files into `source/`.

The format is the ReStructured Text format.

Read [CONTRIBUTING.md](./CONTRIBUTING.md) about the structure.

See below to build the documentation into HTML to see the result.


Contributing by translating the doc into other languages
=========================================================

We are using [Transifex](https://www.transifex.com/3liz-1/lizmap-documentation/)
to translate the documentation. So if you want to contribute to the translation,
create an account on the Transifex web site, and translate different strings.

We retrieve regularly translation and store them into the `i18n/` directory. 

We don't recommend to contribute on translations by doing Pull Request on
github, as it may be difficult to merge content coming from Transifex and your
changes.

Building the documentation
===========================

We are using the tool [Sphinx](https://sphinx-doc.org)  and its 
internationalization mechanism [sphinx-intl](https://sphinx-doc.org/intl.html) to 
generate the HTML content in all languages.

So install these tools. On Linux / MacOs, install Python, Pip and then:

```
sudo pip install -U sphinx
sudo pip install -U sphinx==3.5.4
sudo pip install -U sphinx-intl
```

Then run `make gettext && make html`. It will build the docs in all available 
languages. To run only in English, you can use `make htmlen`.

To see all warnings from Sphinx, your build directory must be empty. It will trigger the full build.
You can use `rm -rf build/ && make htmlen`.

For core contributor
--------------------

See DEV.md to see instructions to push and pull translated files to/from Transifex.
