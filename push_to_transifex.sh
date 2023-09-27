#!/usr/bin/env bash

export LOCALES_BRANCH=$(git branch | grep \* | cut -d ' ' -f2)
echo "Branch on transifex : "${LOCALES_BRANCH}
tx push -s --branch $LOCALES_BRANCH
