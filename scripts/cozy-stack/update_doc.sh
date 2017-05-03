#!/bin/bash

DEFAULT_HOST="cozy1.local:8080"

KEY="test"
VALUE="I want to put it put it"

# check the parameters
if [ $# -lt 2 ] || [ $# -gt 4 ]; then
    echo "Usage : $0 type doc_id update_doc [host] [token]"
    exit 1
fi

TYPE=$1
DOC_ID=$2
FILE=$3

# Host specified
if [ -z "$4" ]; then
    HOST=$DEFAULT_HOST
else
    HOST=$4
fi

# Get token
if [ -z "$5" ]; then
    TOKEN=$(./generate_token.sh $TYPE $HOST)
else
    TOKEN=$5
fi


#echo "var : $TYPE $DOC_ID $HOST $TOKEN"

# Get doc
#DOC=$(./get_doc.sh $TYPE $DOC_ID $HOST $TOKEN) 

#VAL=$DOC |jq .$KEY


#curl -v -X PUT -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" "$HOST/data/$TYPE/$DOC_ID" -d @$FILE


curl -v -X PUT -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" "$HOST/data/$TYPE/$DOC_ID" -d @$FILE

