#!/usr/bin/env bash

rm -rf dist
mkdir dist/

export STORAGE_ACCOUNT_NAME=platopslackhelpbotai
export CONTAINER_NAME=the-hmcts-way

function extractMain () {
    local path=$1

    DIRECTORY=$(dirname "$path")
    mkdir -p dist/$DIRECTORY

    cat $path | htmlq --text 'main' --remove-nodes '[data-module="page-expiry"]' > dist/$path

    TITLE=$(cat ../$path | htmlq 'h1' --text)

    echo "Setting title to $TITLE for $path"
    echo "${TITLE}" > dist/$path.title
}

export -f extractMain

find build -name "*.html" -not -path "build/search/*" -exec bash -c "extractMain \"{}\"" \;
