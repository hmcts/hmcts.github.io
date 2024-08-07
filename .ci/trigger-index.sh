#!/usr/bin/env bash

set -e

API_KEY=$(az search admin-key show \
  --service-name platops-slack-help-bot-ptl \
  --resource-group slack-help-bot-cftptl-intsvc-rg \
  --subscription DTS-CFTPTL-INTSVC \
  --query primaryKey \
  -o tsv)

curl --fail-with-body \
  -X POST \
  -H "api-key: ${API_KEY}" \
  "https://platops-slack-help-bot-ptl.search.windows.net/indexers('the-hmcts-way')/search.run?api-version=2024-07-01" \
  -d ''

echo "Index triggered"
