# Setting up the Training Demo

We are going to create, train and deploy an equivalent model we used previously to detect objects in the realtime streaming images from our webcam via Kafka.

## 1 - Create a project and delete any limts

1. Create a new project using the terminal and delete any limits that get applied to your project. 
***NOTE ask your instructor what your USER value should be***
```
export USER=<ASK INSTRUCTOR>
oc new-project a-model-training-$USER
oc delete limits a-model-training-$USER-core-resource-limits
```
![images/5-model-training-setup/image1.png](images/5-model-training-setup/image1.png)

2. Click your new project on the GUI
![images/5-model-training-setup/image1.png](images/5-model-training-setup/image1.png)

3. Click **Operators > Installed Operators** (ensuring your project is selected on top - though ypur project name will probably be different)




