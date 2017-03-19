#!/bin/bash

curl -X POST -H 'Content-Type: application/json' http://cozy1:8080/sharings/ -d @sharing.json
