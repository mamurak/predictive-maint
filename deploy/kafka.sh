# Prior to running this script, you need to do the following
# 1) Run this to download the Red Hat OpenShift Application Services (RHOAS) Command Line Interface (CLI)
#    curl -o- https://raw.githubusercontent.com/redhat-developer/app-services-cli/main/scripts/install.sh | bash
# 2) Export the location of the RHOAS CLI to your system PATH, 
#    e.g. on mac that's done as follows:
#    export PATH=%PATH%:/Users/<INSERT YOUR USERNAME HERE>/bin
# 3) Create a Red Hat Account - where the SaaS service, Red Hat OpenShift Service for Apache Kafka is located
#    Do that here:
#    http://console.redhat.com
# 4) Using the RHOAS CLI, login to your Red Hat SaaS service. To do that, run the following, 
#    entering your credentials just created, and following the instructions to login.
#    rhoas login


KAFKA_NAME='kafka-rocks'
TOPIC_NAME='video-stream'



export RHOAS_TELEMETRY=true

rhoas --version

rhoas kafka create --name ${KAFKA_NAME}

rhoas context set-kafka --name ${KAFKA_NAME}

while true
do
  STATUS=$(rhoas status)
  PROV='provisioning'
  READY='ready'

  if [[ "$STATUS" == *"$PROV"* ]]; then
    echo "Provisioing"
  elif [[ "$STATUS" == *"$READY"* ]]; then
    echo "Ready"
    break
  fi
  sleep 5
done

rhoas kafka topic create --name ${TOPIC_NAME}

rhoas service-account create --file-format json --short-description="${KAFKA_NAME}-service-account"

CLIENT_ID=$(cat credentials.json | jq  --raw-output '.clientID')
CLIENT_SECRET=$(cat credentials.json | jq  --raw-output '.clientSecret')

echo "$CLIENT_ID"
echo "$CLIENT_SECRET"

#validate service account is created
rhoas service-account list | grep "${KAFKA_NAME}-service-account"

rhoas kafka acl grant-access --consumer --producer --service-account "${CLIENT_ID}" --topic-prefix '*'  --group all

