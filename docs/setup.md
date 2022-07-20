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

Click **Create Kafka instance**
![images/2-setup/image1-png.png](images/2-setup/image1-png.png)










---
---
## 3 - Setup Client Application to capture real-time images from your webcam
Now


## 4 - Configure inference application to pull images from RHOSAK and make predictions
Finally

