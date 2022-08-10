# Set up the Fedora VM
username: redhat  
password: redhat  

# Install packages
```sh
sudo dnf install vim  
sudo dnf install golang opencv*  
sudo dnf install make automake gcc gcc-c++ kernel-devel  
```

# Get repo
```sh
git clone https://github.com/odh-labs/predictive-maint.git  
cd predictive-maint  
```
## Setting up Rhoas cli
```sh
curl -o- https://raw.githubusercontent.com/redhat-developer/app-services-cli/main/scripts/install.sh | bash 
``` 
Open file by running `sudo vim ~/.bash_profile` and add `/home/redhat/.local/bin` at the end of the file    

``` sh
rhoas login  
```
## Setting up oc cli
Download `Openshift v4.10 Linux Client ` from `https://access.redhat.com/downloads/content/290/ver=4.10/rhel---8/4.10.26/x86_64/product-software`  

```sh
cd ~/Downloads/  
tar xvzf oc-4.10.26-linux.tar.gz  
cp oc  /home/redhat/.local/bin/  
```

## Create Kafka instance and update variables in 'consumer-deployment.yaml' file
```sh
cd ~/predictive-maint/deploy/  
./kafka.sh  
```
Save following values that the script prints out (your values will be different):  
1. SASL_USERNAME="b79e3fdb-4e23-4aad-9150-64a50430fed8"
2. SASL_PASSWORD="wVLtwYFNduMPqxJYa2ATMtJSp7gZDFgU"
3. KAFKA_BROKER="kafka-rock-cbpg-usun--h--bua-dg.bf2.kafka.rhcloud.com:443"

## Deployments on Openshift
> login to oc cluster  
```sh
export USER=<user2>  
oc new-project a-predictive-maint-$USER  
oc delete limits a-predictive-maint-$USER-core-resource-limits  

cd ~/predictive-maint/deploy/  
oc apply -f minio-full.yaml  
oc apply -f Seldon-Deployment.yaml  
oc apply -f consumer-deployment.yaml  
```

# Start capturing camera feed

```sh
cd ~/predictive-maint/deploy/
export CLIENT_ID=$(cat credentials.json | jq  --raw-output '.clientID')
export CLIENT_SECRET=$(cat credentials.json | jq  --raw-output '.clientSecret')
export KAFKA_BROKER_URL=$(rhoas status -o json  | jq --raw-output '.kafka.bootstrap_server_host')
```

> Run if you get sasl.username not defined error then uncomment 3 lines below and replace with your own values.
``` sh
#export SASL_USERNAME="<b79e3fdb-4e23-4aad-9150-64a50430fed8>"
#export SASL_PASSWORD="<wVLtwYFNduMPqxJYa2ATMtJSp7gZDFgU>"
#export KAFKA_BROKER="<kafka-rock-cbpg-usun--h--bua-dg.bf2.kafka.rhcloud.com:443>"

cd ~/predictive-maint/event-producer 
go run .
```
  
