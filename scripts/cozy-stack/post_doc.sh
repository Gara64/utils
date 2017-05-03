#!/bin/bash

DEFAULT_HOST="cozy1.local:8080"

# check the parameters
if [ $# -lt 2 ] || [ $# -gt 3 ]; then
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

# Get token
if [ -z "$4" ]; then
    TOKEN=$(./generate_token.sh $TYPE $HOST)
else
    TOKEN=$4
fi

curl -v -H "Host: $HOST" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" "$HOST/data/$TYPE/" -d @$FILE


