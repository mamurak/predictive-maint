
CLIENT_ID=$(cat credentials.json | jq  --raw-output '.clientID')
CLIENT_SECRET=$(cat credentials.json | jq  --raw-output '.clientSecret')

echo "$CLIENT_ID"
echo "$CLIENT_SECRET"

#validate service account is created
rhoas service-account list | grep "${KAFKA_NAME}-service-account"

rhoas kafka acl grant-access --consumer --producer --service-account "${CLIENT_ID}" --topic-prefix '*'  --group all  -y

