# Setting up the Inference Demo


### Prerequisite 1 - Install Virtual B and its extension pack.
Instructions to do it are contained on the [Virtual Box Download page](https://www.virtualbox.org/wiki/Downloads).
If you are using a Mac and have *Homebrew* installed, these commands are a quick way to do it:
```
brew install --cask virtualbox
```
and then 
```
brew install --cask virtualbox-extension-pack
```

### Prerequisite 2 - Download and unzip the edge-based virtual box for this workshop. 
This virtual machine, contains all of the libraries, binaries, command line interfaces etc, that you'll need to 
- interact with, setup and configure your Kafka Streaming service
- interact with, setup and configure your OpenShift based applications, which will - 
  - make the inference calls to the AI prediction service using pulled in realtime from your Kafka Streaming service
  - push the results to your own OpenShift based Object Store S3 implemenation
- retrieve images from your webcam feed in realtime and push them to your Kafka Streaming service

Hit this URL to download the virtual box
# TODO ADD DROPBOX URL

Delpending on your internet speead, this can take several minuites. Once it's complete unzip the file.

### Prerequisite 3 - a Red Hat Account
Next, if you don't already have one, set up a free Red Hat Account - where the SaaS service, Red Hat OpenShift Service for Apache Kafka (RHOASAK) is located. Do that at **https://console.redhat.com**. Logout


### Prerequisite 4 - an OpenShift cluster, a Username and an OpenShift project to work in
You instrutor will supply these to you in the Web Meeting Chat. We'll refer to these below as
```
OPENSHIFT_CLUSTER_URL
YOUR_OPENSHIFT_USERNAME
YOUR_OPENSHIFT_INFERENCE_PROJECT
```
Once these there are complete, you're ready to begin. 

## 1 - Open virtual box then open a terminal inside your virtual box. 
On your laptop, open Virtual Box. A screen like this will appear. Click **Import**:
![images/2-setup/image44.png](images/2-setup/image44.png)
- keep the source *Local File System*
- click the file icon
- navigate to where you unzipped the virtual box earlier
- select the ***ovf*** file
- click Open
![images/2-setup/image45.png](images/2-setup/image45.png)

On the next screen click **Continue**
![images/2-setup/image46.png](images/2-setup/image46.png)

On the following screen, accept the defaults and click **Import**
![images/2-setup/image47.png](images/2-setup/image47.png)

Shortly after, your virtual machine will be available. Click **Start**
![images/2-setup/image48.png](images/2-setup/image48.png)

Enlarge the window and login using the default username ***redhat*** and the password also ***redhat***

You'll see a screen like this. Click the *App Launcher* menu on the bottom. If you don't see it click *Activities* on top.
![images/2-setup/image49.png](images/2-setup/image49.png)

Click **terminal**
![images/2-setup/image50.png](images/2-setup/image50.png)

The Github repository containing this documentation you're reading also contains all source code, scripts, yaml etc that you will need to run this workshop.
We have already cloned this repository into the VM, so you'll just to change directory to it. We'll also set a variable to refer to this directory ***REPO_HOME***. Run the following inside the terminal window:
```
cd predictive-maint
export REPO_HOME=`pwd`
```
***Note - if you want to paste commands from this document to the terminal use this keyboard shortcut***
```
SHIFT + CONTROL + v
```

## 2 - Setup Kafka Cluster on Red Hat OpenShift Streams for Apache Kafka (RHOSAK)
In this section, we're going to automate the configuration of your Kafka streaming service and slot the values from ***your*** new Kafka configuration into various source files so they're ready to use later. Your Kafka streaming service is where
 - images will be sent from your laptop in realtime
 - those same images will be pulled in realtime for your inferencing application on OpenShift


Now, using the terminal inside your virtual box, run the following Kafka automation script
```
cd $REPO_HOME/deploy
. ./kafka.sh
```

You'll be prompted login to your Red Hat Account (you set up previously). A confirmation page like the following will appear on your browser
![images/2-setup/image0-3-Login-confirmation-browser.png](images/2-setup/image0-3-Login-confirmation-browser.png) 

... as well as confirmation on the terminal:
![images/2-setup/image0-4-Login-confirmation.png](images/2-setup/image0-4-Login-confirmation.png)

This script will take several minutes to complete. Keep the terminal open, allowing it to continue the Kafka configuration. 
Feel free to continue from the section below ***3 - Login to OpenShift and select your OpenShift project*** - and come back to the script after 6-7 minutes


#### Confirm your Kafka installation
Come back in 10 minutes to check it has completed successfully.
i.e. do the following:
- Scan your terminal output - it should have run to completion with no errors. The end should look something like this if it was successful:
![images/2-setup/image52.png](images/2-setup/image52.png)

- navigate to [https://console.redhat.com/application-services/streams/kafkas](https://console.redhat.com/application-services/streams/kafkas)
and you should see a new Kafka cluster called  ***kafka-rocks*** created.




## 3 - Login to OpenShift and select your OpenShift project

#### Login to your OpenShift cluster using both browser and terminal
1. Log on to OpenShift - by hitting the URL ***OPENSHIFT_CLUSTER_URL*** you got off the Web Meeting Chat earlier. You'll see this screen. Click **openshift-users** 
![images/2-setup/image40.png](images/2-setup/image40.png)
2. Enter these values and click **Log On**   
   - the value for ***YOUR_OPENSHIFT_USERNAME*** you got earlier for your username
   - ***openshift*** for your password 
 ![images/2-setup/image41.png](images/2-setup/image41.png) 


3. Click the *Perspective* dropdown list box
4. Click the *Administrator* perspective\
   OpenShift changes the user interface to the Adminstrator perspective.
![images/2-setup/image17.png](images/2-setup/image17.png)
5. Click your username on the top right of the screen, then click *Copy Login Command*
![images/2-setup/image18.png](images/2-setup/image18.png)
6.  Login again with your credentials, Click **Display Token**, copy and paste the token into a terminal window (accepting any insecurity warning)
![images/2-setup/image19.png](images/2-setup/image19.png)
Separately, keep a note of the 2 values for
     - OPENSHIFT_API_LOGIN_TOKEN
     - OPENSHIFT_API_LOGIN_SERVER
   You'll need them for the training demo/workshop below

7. Copy the entire ***oc login*** command as far as ***6443*** and paste into your terminal window inside virtual box. Accept the *insecurity* warning.

#### Select your OpenShift project
Now select your project inside the terminal window. Run the following replacing ***YOUR_OPENSHIFT_INFERENCE_PROJECT*** with yours
   ```
   oc project <insert YOUR_OPENSHIFT_INFERENCE_PROJECT here>
   ```
   i.e. in my case, as I'm user30:

![images/2-setup/image42.png](images/2-setup/image42.png) 

Now on the OpenShift Web console (either within or outside your Virtual box VM), navigate to Home > Projects and click ***YOUR_OPENSHIFT_INFERENCE_PROJECT***, in my case *a-predictive-maint-user30*
![images/2-setup/image53.png](images/2-setup/image53.png) 


## 4 - Configure OpenShift based object storage (Minio) and model serving (Seldon)

#### Install the Seldon Deployment

Seldon is an awesome tool to expose the model behind a RESTful API.

1. First you'll need to 

2. Run the following
  ```
   oc apply -f $REPO_HOME/deploy/Seldon-Deployment.yaml
   ```

3. Now let's verify this Seldon deployment you just did on the OpenShift web console. First, click your new project on the GUI
![images/2-setup/image21.png](images/2-setup/image21.png)




# TODO - RESUME HERE





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
```

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

On your laptop, open the file *consumer-deployment.yaml* in the in *deploy* directory the repo code cloned at the beginning. Move down to line 45 where you'll see placeholders for these 4 values (i.e.  ***YOUR_ENVIRONMENT_VARIABLES*** above). Fill them in and **Save the file** (e.g. as shown with mine - obviously your actual values will be different).
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










https://github.com/odh-labs/predictive-maint/blob/main/deploy/consumer-deployment.yaml#L49-L54

