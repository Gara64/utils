#!/bin/bash

DEFAULT_HOST="cozy1:8080"

# check the parameters (n docs)
if [ $# -lt 2 ] || [ $# -gt 4 ]; then
    echo "Usage : post_docs.sh type json_file <host> <token>"
    exit 1
fi

TYPE=$1
FILE=$2

# Host specified
if [ -z "$3" ]; then
    HOST=$DEFAULT_HOST
else
    HOST=$3
fi


# Token defined for authorization
if [ -z "$4" ]; then
    curl -v -H "Host: $HOST" -H "Content-Type: application/json" "localhost:8080/data/$TYPE/" -d @$FILE
else
    curl -v -H "Host: $HOST" -H "Authorization: Bearer $4" -H "Content-Type: application/json" "localhost:8080/data/$TYPE/" -d @$FILE
fi


