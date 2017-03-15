
state=QrSGeYMLTCBfgjMAqxXWoBnGylkhqJfx
clientID=53cb242c5c05fbcafa344f3901012163
scope=""

curl -X POST -F "state=$state" -F "client_id=$clientID" -F "scope=$scope" http://localhost:8080/sharings/answer -H "Host: cozy1:8080"
