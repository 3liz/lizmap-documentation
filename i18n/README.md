Add local
============

* Add a directory for your langage
* Transform \*.pot files from the *pot* directory to \*.po files in your language directory
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

To update to and from Transifex
===============================

You should get an account on [transifex](https://www.transifex.com), and then you must
[create an API Key](https://www.transifex.com/user/settings/api/)

Install [the client for command line](https://docs.transifex.com/client/installing-the-client), 
`tx`, then launch `tx init --skipsetup` so you can indicate your api key.

To retrieve po files from Transifex: `tx pull -l es,fi,fr,it,pt,ru`.

To update po files to Transifex: `tx push -t -l fr`.
To update pot files (english source) to Transifex: `tx push -s `.
