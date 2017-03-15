client_id="ce8835a061d0ef68947afe69a004b5ff"
state=""
scope="test"

curl "http://localhost:8080/auth/authorize?state=$state&scope=$test&response_type=code&redirect_uri=http://localhost:8080/sharings/answer&client_id=$client_id"
