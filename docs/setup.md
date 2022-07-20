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

Copy your *Client ID* and your *Client secret* somewhere safe, click the tickbox and click ***Close*
![images/2-setup/image6.png](images/2-setup/image6.png)

### Get your Kafka Bootstrap server details

Navigate to **Application and Data Services > Streams for Kafka > Kafka Instances**, select the Kafka instance you created earlier (in my case tom-kafka), select the Kebab menu, then Details: 
![images/2-setup/image7.png](images/2-setup/image7.png)

Click the Connection tab and copy your *Bootstrap server*
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





x

x

x

x

x



---
---
## 3 - Setup Client Application to capture real-time images from your webcam
Now


## 4 - Configure inference application to pull images from RHOSAK and make predictions
Finally

