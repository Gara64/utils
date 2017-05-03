#!/bin/bash

# This script executes all the sharing steps, on the sharer and recipient side

SHARER="http://cozy1.local:8080"
RECIPIENT="cozy2.local:8080"

SHARING_TYPE='master-master'

# check the parameters
if [ $# -lt 1 ] ; then
    echo "Usage : $0 value [is_file]"
    exit 1
fi

VAL=$1
IS_FILE=$2

######### Step 1: create recipient: insert and register
RECIPIENT_JSON='
{
    "email": "b@ob.fr",
    "url": "http://'$RECIPIENT'"
}
'
res=$(curl -X POST -H 'Accept: application/json' -H 'Content-Type: application/json' $SHARER/sharings/recipient -d "$RECIPIENT_JSON" | jq '{id: .data.id, client_id: .data.attributes.Client.client_id'})


# The --raw-output allows to avoid the "" in the results
RECIPIENT_ID=$(echo "$res" | jq --raw-output '.id')
#CLIENT_ID=$(echo "$res" | jq --raw-output '.client_id')


######### Step 2: create sharing: insert and send mail

if [ -z "$IS_FILE" ]; then
    TYPE="io.cozy.tests"
    VALUES='["'$VAL'"]'
    SELECTOR="selectortest"
else
    TYPE="io.cozy.files"
    VALUES='["'$VAL'", "io.cozy.sharings.shared-with-me-dir"]'
    SELECTOR="referenced_by"
fi

echo "values : $VALUES"
echo "type : $TYPE"

SHARING_JSON='
{
    "permissions": {
        "io.cozy.photos.albums": {
            "description": "test desc",
            "type": "'$TYPE'",
            "values": ["'$VAL'"],
            "selector": "'$SELECTOR'"
        },
        "album": {
            "description": "test desc2",
            "type": "io.cozy.photos.albums",
            "values": ["'$VAL'"]
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
    "sharing_type": "'$SHARING_TYPE'"
}
'

echo $SHARING_JSON

sharing_res=$(curl -X POST -H 'Content-Type: application/json' $SHARER/sharings/ -d "$SHARING_JSON")

SHARING_ID=$(echo "$sharing_res" |jq --raw-output '.data.attributes.sharing_id')
CLIENT_ID=$(echo "$sharing_res" |jq --raw-output '.data.attributes.recipients[0].Client.client_id')

echo "Sharing ID : $sharing_res"
echo "Client ID : $CLIENT_ID"

######### Step 3: generate sharing url 
if [ -z "$IS_FILE" ]; then
    scope="$TYPE:GET,POST,PUT,DELETE:$VAL:$SELECTOR"
    echo "!! not file"
else
    echo "!!file"
    scope="$TYPE:GET,POST,PUT,DELETE:$VAL:$SELECTOR%20io.cozy.photos.albums:GET,POST,PUT,DELETE:$VAL"
fi
redirect_uri="$SHARER/sharings/answer"

SHARING_LINK="http://$RECIPIENT/sharings/request?state=$SHARING_ID&scope=$scope&response_type=code&redirect_uri=$redirect_uri&client_id=$CLIENT_ID&sharing_type=$SHARING_TYPE" 


######### Step 4: accept sharing on the recipient side 
COOKIE_FILE=headers
CSRF_FILE=csrf

# Activate the sharing link
echo "SHARING LINK : $SHARING_LINK"
curl $SHARING_LINK

# Login to cozy's recipient and save headers to use cookies
curl -X POST -F 'passphrase=cozy' -D "$COOKIE_FILE" "$RECIPIENT/auth/login"
cookie=$(cat "$COOKIE_FILE" |grep "Set-Cookie" | cut -d: -f2 | cut -d$' ' -f2)

# Request the authorize form to get crsf token
curl -c "$CSRF_FILE" -b "$COOKIE_FILE" "$RECIPIENT/auth/authorize?state=$SHARING_ID&scope=$scope&response_type=code&redirect_uri=$redirect_uri&client_id=$CLIENT_ID"

# Build crsf token and cookie
csrf=$(cat "$CSRF_FILE" |grep csrf | rev | cut -d$'\t' -f1 | rev)
auth_cookie="_csrf=$csrf; $cookie" 

# Post authorize with cookie and redirect (-L) option
curl -Lv -H "Cookie: $auth_cookie" "$RECIPIENT/auth/authorize" -d "csrf_token=$csrf&state=$SHARING_ID&scope=$scope&response_type=code&redirect_uri=$redirect_uri&client_id=$CLIENT_ID"


