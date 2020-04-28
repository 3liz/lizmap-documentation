#!/usr/bin/env bash

export LOCALES_BRANCH=$(git branch | grep \* | cut -d ' ' -f2)

tx push -s --branch $LOCALES_BRANCH
