# Setting up the Inference Demo

## 1 - Download the OpenShift CLI

Navigate to [OpenShift CLI Download Page](https://docs.openshift.com/container-platform/4.10/cli_reference/openshift_cli/getting-started-cli.html). (use the newest version - selectable on the top of the page)

Follow the instructions to download the ***oc*** client and add it to your system path.

## 2 - Download the Workshop Files

Using the example below:   
1. Clone (or fork) this repo.
2. Change directory into the root directory of the cloned repository **predictive-maint**.  
3. Create a variable *REPO_HOME* for this directory

```
git clone https://github.com/odh-labs/predictive-maint.git
cd predictive-maint
export REPO_HOME=`pwd`
```


## 3 - Setup Kafka Cluster on Red Hat OpenShift Streams for Apache Kafka (RHOSAK)
In this section, we're going to automate the configuration of your Kafka streaming service
 - to which images will be sent from your laptop in realtime
 - and from which those images will be pulled for your inferencing application on OpenShift, also in realtime
 - there are a few prerequisites to run this automation script, ***kafka.sh*** below

### Prerequisite 1 - RHOAS CLI
Run this to download the Red Hat OpenShift Application Services (RHOAS) Command Line Interface (CLI)
```
cd $REPO_HOME
curl -o- https://raw.githubusercontent.com/redhat-developer/app-services-cli/main/scripts/install.sh | bash
```

You should see a confirmation message, including the location the CLI was installed to:
![images/2-setup/image0-1-terminal.png](images/2-setup/image0-1-terminal.png)

Now, you need to add that to your path - e.g. on a Mac:
```
export PATH=$PATH:/Users/<INSERT YOUR USERNAME HERE>/bin
```
in my case:
![images/2-setup/image0-2-export-path.png](images/2-setup/image0-2-export-path.png)

### Prerequisite 2 - a Red Hat Account
Next, if you don't already have one, set up a free Red Hat Account - where the SaaS service, Red Hat OpenShift Service for Apache Kafka (RHOASAK) is located. Do that at **https://console.redhat.com**. Logout

### Prerequisite 3 - JQ, the lightweight command-line JSON processor.
Install this on your laptop, e.g. in my case on a Mac, I needed to run this in order to run the command:
```
brew install jq
```

### Prerequisite 4 - Remove credentials.json if you ran ***kafka.sh*** before.
If this is your first time to run ***kafka.sh***, ignore this step.

Otherwise run the following:
```
rm $REPO_HOME/deploy/credentials.json
```

### Prerequisite 5 - Install the **Go** programming language on your laptop
In a terminal on your laptop, install the **Go** programming language if you don't have it already. Instructions here: https://go.dev/doc/install.

In my case on a Mac, I just needed to run:
```
brew install go
brew install opencv
```


### Run Kafka automation script
Now, using ta terminal on your laptop, run the following
```
cd $REPO_HOME/deploy
sh kafka.sh
```

You'll be prompted login to your Red Hat Account (you set up previosly). A confirmation page like the following will appear on your browser
![images/2-setup/image0-3-Login-confirmation-browser.png](images/2-setup/image0-3-Login-confirmation-browser.png) 

... as well as confirmation on the terminal:
![images/2-setup/image0-4-Login-confirmation.png](images/2-setup/image0-4-Login-confirmation.png)

This script will take several minutes to complete. Keep the terminal open, allowing it to continue the Kafka configuration. 
Feel free to move to the section below ***4 - Configure OpenShift based object storage (Minio) and model serving (Seldon)*** - and come back to the script after 10 minutes


### Confirm your Kafka installation
Come back in 10 minutes to check it has completed successfully.
i.e. do the following:
- Scan your terminal output - it should have run to completion with no errors.
- You'll need to record 2 items of data in your terminal output. Towards the end of the output, just before the section ***The following ACL rules will be created***, your client id and secret appear. Copy these 2 items - we'll refer to them as ***SASL_USERNAME*** and ***SASL_PASSWORD*** below. ![images/2-setup/image0-5-get-client-id-secret.png](images/2-setup/image0-5-get-client-id-secret.png)
- navigate to [https://console.redhat.com/application-services/streams/kafkas](https://console.redhat.com/application-services/streams/kafkas)
and drill into your new ***kafka-rocks*** Kafka cluster and see a new Topic ***video-stream***, and configuration under the Access tab have been added.


### Get your Kafka Bootstrap server details

- Navigate to **Application and Data Services > Streams for Kafka > Kafka Instances**, (or just hit [https://console.redhat.com/application-services/streams/kafkas](https://console.redhat.com/application-services/streams/kafkas)). 
- Select the Kafka instance you created earlier (in my case tom-kafka), select the Kebab menu
- Click Details: 
![images/2-setup/image7.png](images/2-setup/image7.png)

- Click the Connection tab and copy your *Bootstrap server*. We'll refer to this below as YOUR_KAFKA_BOOTSTRAP_SERVER (in my case *tom-kafka-cbdk-spfgjklbiqle--a.bf2.kafka.rhcloud.com:443*)
![images/2-setup/image8.png](images/2-setup/image8.png)


## 4 - Configure OpenShift based object storage (Minio) and model serving (Seldon)

### Login to your OpenShift cluster 
1. Log on to OpenShift as a Cluster Administrator. (For RHPDS this is opentlc-mgr.)
2. Click the *Perspective* dropdown list box
3. Click the *Administrator* perspective\
   OpenShift changes the user interface to the Adminstrator perspective.
![images/2-setup/image17.png](images/2-setup/image17.png)
4. Click your username on the top right of the screen, then click *Copy Login Command*
![images/2-setup/image18.png](images/2-setup/image18.png)
5.  Login again with your credentials, Click **Display Token**, copy and paste the token into a terminal window (accepting any insecurity warning)
![images/2-setup/image19.png](images/2-setup/image19.png)
Separately, keep a note of the 2 values for
 - OPENSHIFT_API_LOGIN_TOKEN
 - OPENSHIFT_API_LOGIN_SERVER
You'll need them for the training demo/workshop below

### Install the Seldon Operator and Seldon Deployment

The Seldon operator is required to expose the model behind a RESTful API.

1. Create a new project using the terminal and delete any limits that get applied to your project. 
***NOTE ask your instructor what your USER value should be***
```
export USER=<ASK INSTRUCTOR>
oc new-project a-predictive-maint-$USER
oc delete limits a-predictive-maint-$USER-core-resource-limits
```
![images/2-setup/image20.png](images/2-setup/image20.png)

2. Click your new project on the GUI
![images/2-setup/image21.png](images/2-setup/image21.png)
3. Click **Operators > Operator Hub** (ensuring your project is selected on top - though ypur project name will probably be different)
   ![images/2-setup/image22.png](images/2-setup/image22.png)
   OpenShift displays the operator catalogue.  
4.  Click the *Filter by keybord* text box and type *seldon*  
   OpenShift displays the *Seldon* tile.
5. Click the **Community Seldon Operator**  
   OpenShift displays a Commmunity Operator warning dialog box.
   ![images/2-setup/image23.png](images/2-setup/image23.png)
6. Click **Continue**  
   OpenShift displays a community operator warning. Accept it by clicking *Continue*.
7. OpenShift displays the operator details. Click **Install**   
 ![images/2-setup/image24.png](images/2-setup/image24.png)     
8. OpenShift prompts for the operator configuration details. Accept all defaults and click **Install**\
 ![images/2-setup/image25.png](images/2-setup/image25.png)
   OpenShift installs the operator and displays a confirmation box once complete a few minutes later.  
9. Click **Installed Operators**, ensuring your new project is selected on top. See the installation has succeeded. Click **Seldon Operator** 
 ![images/2-setup/image26.png](images/2-setup/image26.png)

10. Click **Seldon Deployment** then **Create Seldon Deployment**
 ![images/2-setup/image27.png](images/2-setup/image27.png)

11. On your laptop (or wherever you cloned this repositiory above), navigate to and copy the entire contents of the file **deploy > Seldon-Deployment.yaml**
 ![images/2-setup/image28.png](images/2-setup/image28.png)

12. Back on OpenShift, choose **YAML view** and replace the default YAML with what you copied in the previous step. Click **Create**
 ![images/2-setup/image29.png](images/2-setup/image29.png)
 A few minutes this should be complete. We have configured this so approximately 20 pods are instantiated. This is to ensure the AI program responds very quickly to changing images sent from your laptop.

### Install Minio, our lightweight Object Storage implementation


1. In your terminal window, type the following commands:
   ```
   oc apply -f $REPO_HOME/deploy/minio-full.yaml
   ```


### Setup your Minio Object Storage

## Get your Minio URL (Route)
1. In OpenShift, move to **Workloads > Pods**. After a few minutes, both your Minio and Seldon pods should be Running and Ready. (ignore any initial errors for the first couple of minutes - they will work themselves out)
![images/2-setup/image30.png](images/2-setup/image30.png)

2. Navigate back to **Networking > Routes**. Take a note the OpenShift Route for 
   - the first Minio Route (i.e. the one without ***ui***)
![images/2-setup/image34.png](images/2-setup/image34.png)

1. We'll need to take note of
   - FULL_MINIO_API_ROUTE - which is your *Minio API Route* from the previous step ***WITH*** the HTTP protocol
   ```
   FULL_MINIO_API_ROUTE
   http://minio-ml-workshop-a-predictice-maint.apps.cluster-spvql.spvql.sandbox67.opentlc.com
   ```
   - MINIO_API_URL - which is your *Minio API Route* from the previous step - ***WITHOUT*** the HTTP protocol
   ```
   YOUR_MINIO_API_URL
   minio-ml-workshop-a-predictice-maint.apps.cluster-spvql.spvql.sandbox67.opentlc.com

## 5 - Record your Environment Variables
When you later run 
1. your edge based webcam image retrieval client
2. your OpenShift based inference service

you'll need to configure each with various ENVIROMENT variables.

They're summarised here in a generalised format:
```
SASL_USERNAME="<SASL_USERNAME recorded above>"
SASL_PASSWORD="<SASL_PASSWORD recorded above>"
KAFKA_BROKER="<YOUR_KAFKA_BOOTSTRAP_SERVER recorded above>"
MINIO_SERVER="<YOUR_MINIO_API_URL recorded above>"

Take a note of these four values, that are specific to you as a user. We'll refer to these as ***YOUR_ENVIRONMENT_VARIABLES***


## 6 - Setup Client Application to capture real-time images from your webcam

# TODO - REPLACE WITH VIRTUAL BOX

We need to set up the application on your laptop that captures images in realtime from your webcam and pushes them to the ***video-stream*** Kafka topic you created earlier - from which the inferencing application will pull them.

Now change directory to the *event-producer* directory in the repo code cloned at the beginning.
```
cd $REPO_HOME/event-producer
```

The final thing you'll need to do before running your client is export five of ***YOUR_ENVIRONMENT_VARIABLES*** from above. Just place the export command in front of each and hit enter. 
```
export SASL_USERNAME="<SASL_USERNAME recorded above>"
export SASL_PASSWORD="<SASL_PASSWORD recorded above>"
export KAFKA_BROKER="<YOUR_KAFKA_BOOTSTRAP_SERVER recorded above>"
```
i.e. in my case:
![images/2-setup/image35.png](images/2-setup/image35.png)

Now your client is ready. We'll use it in the next instruction file, [Run End to End Inference Demo](https://github.com/odh-labs/predictive-maint/blob/main/docs/image-detection-inference-demo.md)


## 7 - Configure your OpenShift inference application to pull images from RHOSAK and make realtime predictions

We have a simple OpenShift based application that 
- pulls images from our video-stream Kafka topic we set up earlier
- for each one, it calls the Model via the MODEL_URL value above (always http://model-1-pred-demo:8000/api/v1.0/predictions) for a prediction on what the image contains
- writes the count of what it found out to our Object Storage Minio
  
We simply need to configure it ***YOUR_ENVIRONMENT_VARIABLES*** that you set up previously.

On your laptop, open the file *consumer-deployment.yaml* in the in *deploy* directory the repo code cloned at the beginning. Move down to line 45 where you'll see placeholders for ***YOUR_ENVIRONMENT_VARIABLES***. Fill them in and **Save the file** (e.g. as shown with mine).
![images/2-setup/image36.png](images/2-setup/image36.png)

## 8 - Configure your simple HTML dashboard that records a count of the objects it sees

We have a simple HTML page that polls our Minio Object Storage bucket for the count of how many of each item the AI has recorded.

It's this file
```
$REPO_HOME/deploy/show_data.html
```

Open the file using a text editor and change line 7.
![images/2-setup/image37.png](images/2-setup/image37.png)

i.e. replace ***CHANGE_ME_FULL_MINIO_API_ROUTE*** with your ***FULL_MINIO_API_ROUTE*** retrieved above
```
'[CHANGE_ME_FULL_MINIO_API_ROUTE]/image-prediction/'
```
... in my case 
![images/2-setup/image38.png](images/2-setup/image38.png)


Now your inference application is ready. We'll use it in the next instruction file, [Run End to End Inference Demo](https://github.com/odh-labs/predictive-maint/blob/main/docs/image-detection-inference-demo.md)
