# Documentation Lizmap 📚

This repository contains the complete documentation of the Lizmap application.

Lizmap allows publishing online QGIS maps.

The documentation is localized into several languages. The main language is
the English.

## Contributing to the English documentation

Clone the repository and edit files into `source/`.

The format is the ReStructured Text format.

Read [CONTRIBUTING.md](./CONTRIBUTING.md) about the structure.

See below to build the documentation into HTML to see the result.

## Contributing by translating into other languages

We are using [Transifex](https://www.transifex.com/3liz-1/lizmap-documentation/)
to translate the documentation. So if you want to contribute to the translation,
create an account on the Transifex website, and translate different strings.

We retrieve regularly translation and store them into the `i18n/` directory. 

We don't recommend contributing to translations by doing a Pull Request on
GitHub, as it may be difficult to merge content coming from Transifex and your
changes.

## Building the documentation

We are using the tool [Sphinx](https://sphinx-doc.org) and its
internationalization mechanism [sphinx-intl](https://sphinx-doc.org/intl.html) to
generate the HTML content in all languages.

So install these tools. On Linux / macOS, install Python, Pip and then:

```bash
pip install -U sphinx==1.8.6
# pip install -U sphinx-intl
```

Then run `make gettext && make html`. It will build the docs in all available 
languages. To run only in English, you can use `make htmlen`.

To see all warnings from Sphinx, your build directory must be empty. It will trigger the full build.
You can use `rm -rf build/ && make htmlen`.

## For core contributor

See DEV.md to see instructions to push and pull translated files to/from Transifex.
