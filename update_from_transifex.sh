#!/usr/bin/env bash

LOCALES_DIR="$(dirname $0)"

export LOCALES_BRANCH=$(git branch | grep \* | cut -d ' ' -f2 | sed -r 's/_/-/g')
export AVAILABLE_LOCALES="es fi fr it wq ja pt ru cs uk_UA"

usage()
{
    echo "$0 [options] [locale]"
    echo ""
    echo "This script pull translations from transifex. It pull translations"
    echo "of all languages or only the one given in parameter."
    echo ""
    echo "Options:"
    echo "   -f    force to update translations, regardless of whether timestamps"
    echo "         on the local computer are newer than those on the server"
    echo "   "

}

FORCE=""
ALL_LOCALES=""

for i in $*
do
case $i in
    -h|--help)
    usage
    exit 0
    ;;
    -f|--force)
    FORCE="-f"
    ;;
    -*)
      echo "ERROR: Unknown option: $i"
      echo ""
      usage
      exit 1
    ;;
    *)
    if [ "$ALL_LOCALES" = "" ]; then
        ALL_LOCALES="$i"
    else
        echo "ERROR: Two many arguments"
        usage
        exit 3
    fi
    ;;
esac
done




if [ "$ALL_LOCALES" == "" ]; then
  ALL_LOCALES=$(echo "$AVAILABLE_LOCALES" | sed -r 's/ /,/g')
fi

echo $ALL_LOCALES $LOCALES_BRANCH

tx -H $TX_API -t $TX_TOKEN pull $FORCE --mode default -l "$ALL_LOCALES" --branch $LOCALES_BRANCH
