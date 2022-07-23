# Running the Inference Demo

Ensure you have setup this demo first, as instructed in [Setup Inference Demo](https://github.com/odh-labs/predictive-maint/blob/main/docs/image-detection-inference-demo-setup.md)

## 1 - Download the OpenShift CLI

Go to the terminal you setup in [Setup Client Application to capture real-time images from your webcam](https://github.com/odh-labs/predictive-maint/blob/main/docs/image-detection-inference-demo-setup.md#6---setup-client-application-to-capture-real-time-images-from-your-webcam)

Run the following
```
cd $REPO_HOME/event-producer
go run .
```
![images/3-inference-demo/image1.png](images/3-inference-demo/image1.png)

This will immediately start pulling images from your webcam and sending them to Kafka. You'll see something like this on your terminal

![images/3-inference-demo/image2.png](images/3-inference-demo/image2.png)


## 2 - Download the Workshop Files
