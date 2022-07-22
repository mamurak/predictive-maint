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
First, Login to **https://console.redhat.com** - you may need to create a free account.

Navigate to **Application and Data Services > Streams for Kafka > Kafka Instances**

or just hit:   [https://console.redhat.com/application-services/streams/kafkas](https://console.redhat.com/application-services/streams/kafkas)

### Create Kafka Instance

Click **Create Kafka instance**
![images/2-setup/image1-png.png](images/2-setup/image1-png.png)

Name it, stick with a Single Availability zone and click **Create instance**
![images/2-setup/image2.png](images/2-setup/image2.png)

Do to the next section (*Create Service Account*) and then come back here - at which point the Status should be **Ready** as seen here:
![images/2-setup/image3.png](images/2-setup/image3.png)

### Create Service Account

Navigate to **Service Accounts** and click **Create Service Account**
![images/2-setup/image4.png](images/2-setup/image4.png)

Give your Service Account a description and click **Create**
![images/2-setup/image5.png](images/2-setup/image5.png)

Copy your *Client ID* and your *Client secret* somewhere safe. We'll refer to these below as YOUR_CLIENT_ID and YOUR_CLIENT_SECRET. Click the tickbox and click ***Close*
![images/2-setup/image6.png](images/2-setup/image6.png)

### Get your Kafka Bootstrap server details

Navigate to **Application and Data Services > Streams for Kafka > Kafka Instances**, select the Kafka instance you created earlier (in my case tom-kafka), select the Kebab menu, then Details: 
![images/2-setup/image7.png](images/2-setup/image7.png)

Click the Connection tab and copy your *Bootstrap server*. We'll refer to this below as YOUR_BOOTSTRAP_SERVER
![images/2-setup/image8.png](images/2-setup/image8.png)

### Create your Kafka topic

Return to the **Kafka Instances** screen and click into your Kafka instance:
![images/2-setup/image9.png](images/2-setup/image9.png)

Click **Topics** then **Create Topic**
![images/2-setup/image10.png](images/2-setup/image10.png)



Fill it in ***exactly*** as follows, clicking **Next** between selections and **Finish** at the end
```
Name:		        video-stream
Partitions:	        10
Retention time:         go with the defaults
Retention size:         go with the defaults
Replicas:               go with the defaults
```

### Configure Access

Still within your new Kafka instance, click **Access** then click **Manage Access**
![images/2-setup/image11.png](images/2-setup/image11.png)

Click the **Account** dropdown and select the new Service Account you created above
![images/2-setup/image12.png](images/2-setup/image12.png)

Click **Next**

![images/2-setup/image13.png](images/2-setup/image13.png)


Move to the *Assign permissions* section on the bottom of the window and click **Add permission** (note click the *Add Permission* text, not the dropdown's arrow)
![images/2-setup/image14.png](images/2-setup/image14.png)

Fill in access details as follows:
![images/2-setup/image15.png](images/2-setup/image15.png)

Now click **Add permission** (this time ***DO*** click the arrow), choose **Produce to a topic** and fill in as below.

Then click **Add permission** (again this time ***DO*** click the arrow), choose **Consume from a topic** and fill in as below

This is how your permission assigments should now look. Click **Save**
![images/2-setup/image16.png](images/2-setup/image16.png)


## 4 - Configure OpenShift based storage and inference application to pull images from RHOSAK and make predictions

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

### Install the Seldon Operator

The Seldon operator is required to expose the model behind a RESTful API.

1. Create a new project using the terminal
![images/2-setup/image20.png](images/2-setup/image20.png)
2. Click your new project on the GUI
![images/2-setup/image21.png](images/2-setup/image21.png)
3. Click **Operators > Operator Hub** (ensuring your project is selected on top)
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
9. Click *Installed Operators*, ensuring your new project is selected on top. See the installation has succeeded. Click Seldon Operator 
 ![images/2-setup/image26.png](images/2-setup/image26.png)

10. 











x

x

x

x

x



---
---

## 3 - Setup Client Application to capture real-time images from your webcam
Now

