#!/bin/bash

DEFAULT_HOST="cozy1.local:8080"

# check the parameters 
if [ $# -lt 2 ]; then
    echo "Usage : $0 type docid [host] [token]"
    exit 1
fi

TYPE=$1
DOC_ID=$2

# Host specfied
if [ -z $3 ]; then
    HOST=$DEFAULT_HOST
else
    HOST=$3
fi

# Get token
if [ -z "$4" ]; then
    TOKEN=$(./generate_token.sh $TYPE $HOST)
else
    TOKEN=$4
fi

curl  -H "Authorization: Bearer $TOKEN" "$HOST/data/$TYPE/$DOC_ID"


