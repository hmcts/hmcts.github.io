#!/usr/bin/env bash

export STORAGE_ACCOUNT_NAME=platopslackhelpbotai
export CONTAINER_NAME=the-hmcts-way

# we use sync here so that deleted files get removed
azcopy sync --compare-hash=md5 \
  --delete-destination=true \
  --include-pattern="*.html"  \
  "dist/" "https://$STORAGE_ACCOUNT_NAME.blob.core.windows.net/$CONTAINER_NAME/"

function setTitle() {
    local path=$1

    TITLE=$(cat $path.title)

    echo "Setting title to $TITLE for $path"

    az storage blob metadata update --auth-mode login --account-name $STORAGE_ACCOUNT_NAME --container-name $CONTAINER_NAME --name $path --metadata title="$TITLE"
}

export -f setTitle

pushd dist
# another pass over to set the file title as a metadata attribute
find . -name "*.html" -exec bash -c "setTitle \"{}\"" \;

popd
