# Running the Inference Demo

Ensure you have setup this demo first, as instructed in [Setup Inference Demo](https://github.com/odh-labs/predictive-maint/blob/main/docs/image-detection-inference-demo-setup-v2.md)

## 1 - Open webpage on your VM that reports what the AI model sees

### Navigate to HTML file
Inside your VM, again click **Activities** then this time click the *files* button on the bottom
![images/3-inference-demo/image7.png](images/3-inference-demo/image7.png)

The files view will open. 
![images/3-inference-demo/image8.png](images/3-inference-demo/image8.png)


Click into **predictive-maint** then into **deploy**. Double click on ***show_data.html*** 
![images/3-inference-demo/image9.png](images/3-inference-demo/image9.png)

That HTML file will open in Firefox. Resize Firefox and your terminal so they are both visible 
![images/3-inference-demo/image10.png](images/3-inference-demo/image10.png)

Now, you'll need to paste the address of your Minio API object storage storage into the textbox on the html file. You'll recall earlier, on OpenShift you retrieved your ***FULL_MINIO_API_ROUTE*** - the value beside ***1*** here:
 ![images/2-setup/image56.png](images/2-setup/image56.png)

Copy that ***FULL_MINIO_API_ROUTE*** value and paste into the ***show_data.html*** file.

***DON'T CLICK the Start Fetching button yet***.

## 2 - Run the OpenShift inference application to pull images from Kafka and make realtime predictions

Run this in the terminal in your VM.
```
oc apply -f $REPO_HOME/deploy/consumer-deployment.yaml
```

Switch to OpenShift and move to the pods view. In a couple of minutes, you should have a new pod Running and Ready for your inference application. 
![images/3-inference-demo/image4.png](images/3-inference-demo/image4.png)

This application is pulling images off the Kakfa streaming service and for each one it calls the ***Seldon exposed*** AI model - which predicts what it is seeing in that image.

The default model, writes a count of the following:
- the number of images it sees a person, i.e. you
- the number it sees soemthing else, we call those ***background***
Of course, the model can be trained to detect other objects, machinery damage, cancerous cells etc. More on that in the next section of the workshop.


## 3 - Run the Edge (VM based) Application to capture real-time images from your webcam

We're about to run an application inside the VM on your laptop that uses your webcam to pull images it sees and send them to Kafka. Go to the terminal inside your VM and run the following
```
cd $REPO_HOME/event-producer
go run .
```
![images/3-inference-demo/image1.png](images/3-inference-demo/image1.png)

This will immediately start pulling images from your webcam and sending them to Kafka. You'll see something like this on your terminal

![images/3-inference-demo/image6.png](images/3-inference-demo/image6.png)

Keep youself visible to the webcam for now

## 3 - Get ***show_data.html*** file to report on images


In a few seconds, you'll see the value of ***Person*** increasing. As soon as you do, put your hand in front of your webcam, so it can't see you. Within a few seconds, the object increasing should change from ***Person*** to ***Background***

This is awesome - it's detecting in realtime what your webcam sees!

When closing down your machine, save the machine state so you can revisit your work.

## Next workshop

Next we'll retrain our model so it can recognise objects other than a Person.

To that, move to [Set Up Model Training Demo](https://github.com/odh-labs/predictive-maint/blob/main/docs/image-detection-train-model-demo-setup.md)

