#!/bin/bash

DEFAULT_HOST="cozy1:8080"

# check the parameters
if [ $# -lt 2 ] || [ $# -gt 4 ]; then
    echo "Usage : $0 type json_file [host] [token]"
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
    curl -v -H "Host: $HOST" -H "Content-Type: application/json" "$HOST/data/$TYPE/" -d @$FILE
else
    curl -v -H "Host: $HOST" -H "Authorization: Bearer $4" -H "Content-Type: application/json" "$HOST/data/$TYPE/" -d @$FILE
fi


