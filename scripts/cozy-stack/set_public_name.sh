#!/bin/bash

DEFAULT_HOST="cozy1:8080"

if [ $# -lt 1 ]; then
    echo "Usage : $0 public_name [host] "
    exit 1
fi

# Host specfied
if [ -z $2 ]; then
    HOST=$DEFAULT_HOST
else
    HOST=$2
fi

DOCTYPE="io.cozy.settings"
ID="io.cozy.settings.instance"

TOKEN=$(bash generate_token.sh $DOCTYPE $HOST)
echo "token : $TOKEN"

REV=$(curl -H "Authorization: Bearer $TOKEN" "$HOST/data/$DOCTYPE/$ID" | jq '._rev') 

echo 'rev : '"$REV"''
echo 'id : '"$ID"''
echo '{"_id": '"$ID"',"_rev": '"$REV"'}'

curl -X PUT -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json"  "$HOST/data/$DOCTYPE/$ID" -d '{"_id": "'"$ID"'","_rev": '"$REV"', "public_name": "'"$1"'"}'

