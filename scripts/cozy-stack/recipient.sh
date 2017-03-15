token=$(<recipient.token)

curl -X POST -H "Authorization: Bearer $token" -H 'Host: cozy1:8080' -H 'Accept: application/json' -H 'Content-Type: application/json' http://localhost:8080/data/io.cozy.recipients/ -d @recipient.json
