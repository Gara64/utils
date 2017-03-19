#!/bin/bash

# This script executes all the sharing steps, on the sharer and recipient side

SHARER="http://cozy1:8080"
RECIPIENT="cozy2:8080"

# check the parameters
if [ $# -lt 1 ] ; then
    echo "Usage : $0 docid"
    exit 1
fi

DOC_ID=$1


######### Step 1: create recipient: insert and register
RECIPIENT_JSON='
{
    "email": "b@ob.fr",
    "url": "'$RECIPIENT'"
}
'
res=$(curl -X POST -H 'Accept: application/json' -H 'Content-Type: application/json' $SHARER/sharings/recipient -d "$RECIPIENT_JSON" | jq '{id: .data.id, client_id: .data.attributes.Client.client_id'})


# The --raw-output allows to avoid the "" in the results
RECIPIENT_ID=$(echo "$res" | jq --raw-output '.id')
CLIENT_ID=$(echo "$res" | jq --raw-output '.client_id')


######### Step 2: create sharing: insert and send mail
SHARING_JSON='
{
    "permissions": {
        "tests": {
            "description": "test",
            "type": "io.cozy.tests",
            "verbs": ["GET", "POST"],
            "values": ["'$DOC_ID'"]
        }
    },
    "recipients": [
        {
            "recipient": {
                "type": "io.cozy.recipients",
                "id": "'$RECIPIENT_ID'"
            }
        }
    ],
    "desc": "I want you to go elsewhere!",
    "sharing_type": "one-shot"
}
'

SHARING_ID=$(curl -X POST -H 'Content-Type: application/json' $SHARER/sharings/ -d "$SHARING_JSON" | jq --raw-output '.data.attributes.sharing_id')


######### Step 3: generate sharing url 
sharing_type="one-shot"
scope="test"
redirect_uri="$SHARER/sharings/answer"

SHARING_LINK="$RECIPIENT/auth/authorize?state=$SHARING_ID&scope=$scope&response_type=code&redirect_uri=$redirect_uri&client_id=$CLIENT_ID" 


######### Step 4: accept sharing on the recipient side 
COOKIE_FILE=headers
CSRF_FILE=csrf

# Login to cozy's recipient and save headers to use cookies
curl -X POST -F 'passphrase=cozy' -D "$COOKIE_FILE" "$RECIPIENT/auth/login"
cookie=$(cat "$COOKIE_FILE" |grep "Set-Cookie" | cut -d: -f2 | cut -d$' ' -f2)

# Request the authorize form to get crsf token
curl -c "$CSRF_FILE" -b "$COOKIE_FILE" "$RECIPIENT/auth/authorize?state=$SHARING_ID&scope=$scope&response_type=code&redirect_uri=$redirect_uri&client_id=$CLIENT_ID"

# Build crsf token and cookie
csrf=$(cat "$CSRF_FILE" |grep csrf | rev | cut -d$'\t' -f1 | rev)
auth_cookie="_csrf=$csrf; $cookie" 

# Post authorize with cookie and redirect (-L) option
curl -L -H "Cookie: $auth_cookie" "$RECIPIENT/auth/authorize" -d "csrf_token=$csrf&state=$SHARING_ID&scope=$scope&response_type=code&redirect_uri=$redirect_uri&client_id=$CLIENT_ID"


