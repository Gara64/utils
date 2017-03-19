state="dLsISEeQuiCtKRKQfzPwkuEbYGQzzBXK"
sharing_type="one-shot"
scope="test"
redirect_uri="http://cozy1:8080/sharings/answer"
client_id="24c1c5ea5cf1c7644e8c7c454e352f37"
response_type="code"

curl -v -H 'Content-Type: application/json' -H 'Accept: application/json' "http://cozy2:8080/sharings/request?state=$state&sharing_type=$sharing_type&scope=$scope&redirect_uri=$redirect_uri&client_id=$client_id&response_type=$response_type"
