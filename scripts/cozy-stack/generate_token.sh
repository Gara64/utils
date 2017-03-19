#!/bin/bash

DEFAULT_HOST="cozy1:8080"

if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    echo "Usage : $0 doctype [host] "
    exit 1
fi

# Host specfied
if [ -z $2 ]; then
    HOST=$DEFAULT_HOST
else
    HOST=$2
fi
DOCTYPE=$1

COZY_CLIENT_ID=$(cozy-stack instances client-oauth cozy1:8080 $HOST test github.com/cozy/test)

COZY_STACK_TOKEN=$(cozy-stack instances token-oauth $HOST $COZY_CLIENT_ID $DOCTYPE)

echo $COZY_STACK_TOKEN
