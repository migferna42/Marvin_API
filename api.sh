#!/usr/bin/env bash

RESOURCE=$2
NAME=$3

TOKEN=$(curl -s -X POST --data "grant_type=client_credentials&client_id=$CLIENT_ID&client_secret=$CLIENT_SECRET" https://api.intra.42.fr/oauth/token | jq '.access_token' | tr -d '"')
#echo $TOKEN
ID_CAMPUS=$(curl -s -H "Authorization: Bearer $TOKEN" "https://api.intra.42.fr/v2/campus/" | jq  '.[] | select(.city=='\"$NAME\"')' | jq '.id' )
#echo $ID_CAMPUS

curl -s -H "Authorization: Bearer $TOKEN" "https://api.intra.42.fr/v2/campus/$ID_CAMPUS/$RESOURCE" | jq
