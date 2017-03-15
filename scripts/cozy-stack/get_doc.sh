#!/bin/bash

DEFAULT_HOST="cozy1:8080"

# check the parameters (n docs)
if [ $# -lt 2 ] || [ $# -gt 4 ]; then
    echo "Usage : get_docs.sh type docid <host> <token>"
    exit 1
fi

# Host specfied
if [ -z $3 ]; then
    HOST=$DEFAULT_HOST
else
    HOST=$3
fi

# Token defined for authorization
if [ -z $4 ]; then
    curl -v -H "Host: $HOST" "localhost:8080/data/$1/$2"
else
    curl -v -H "Host: $HOST" -H "Authorization: Bearer $4" "localhost:8080/data/$1/$2"
fi


