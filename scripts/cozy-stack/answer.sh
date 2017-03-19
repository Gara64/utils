
state=CmouNSFZGwrjEstTcVRpEMnnmksCJtFc
clientID=24c1c5ea5cf1c7644e8c7c454e2eaae2
accessCode=24c1c5ea5cf1c7644e8c7c454e30ce18
scope=""

curl -X POST -F "state=$state" -F "client_id=$clientID" -F "scope=$scope" -F "access_code=$accessCode" http://cozy1:8080/sharings/answer
