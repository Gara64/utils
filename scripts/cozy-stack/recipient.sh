#!/bin/bash

curl -X POST -H 'Accept: application/json' -H 'Content-Type: application/json' http://cozy1:8080/sharings/recipient -d @recipient.json
