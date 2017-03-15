state="1234"
sharing_type="one-shot"
scope="test"
redirect_uri="https://client.example.org/oauth/callback"
client_id="ce8835a061d0ef68947afe69a004b5ff"
response_type="code"

curl -v -H "Host: cozy1:8080" -H 'Content-Type: application/json' -H 'Accept: application/json' "http://localhost:8080/sharings/request?state=$state&sharing_type=$sharing_type&scope=$scope&redirect_uri=$redirect_uri&client_id=$client_id&response_type=$response_type"
