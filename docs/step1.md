---
layout: default
nav_order: 2
---
[Back to the introduction](index.md)

# Step 1: Starting a Jupyter environment

You should be logged into **Red Hat OpenShift Data Hub**, and be able to see the dashboard, that looks like this:

![alt text](./assets/img/Jupyter_hub_route.png "Red Hat OpenShift networking Routes")


**Red Hat OpenShift Data Hub** brings you on-demand Jupyter Notebooks environments. Don't worry if you've never used notebooks before as this workshop will start with a small tutorial on what they are and how to use them.

* Now that you are logged into to **Red Hat OpenShift Data Hub**, click on the "Launch" link on the JupyterHub card:

![alt text](./assets/img/Jupyter_hub_link.png "JupyterHub route")

If it's the first time you're launching Jupyter, you will be sent to a page that will require you to login and ask for your authorization to use your user account to authenticate to Jupyter. You should of course allow this if you want to do the workshop...

Once you have authorized access, you will be taken to the JupyterHub "Spawner Options" page.

* From the "Start a notebook server" page, there are multiple options you can choose from to launch your environment.
  * For the **Notebook Image** , select **TensorFlow**, as this is the flavor of notebook we want to use. It includes the TensorFlow library, which is used to do image recognition.
  * From the **Container size** dropdown, select `Large`.

![alt text](./assets/img/j_start.png "select the environment")


  * Enter your personal  **Environment variables**. 

      * OPENSHIFT_API_LOGIN_SERVER
      * OPENSHIFT_API_LOGIN_TOKEN
  
![alt text](./assets/img/enviroment_variables.png "Enter the environment variables")

  * At the bottom of the page you can now click on the **Start Server** button:

![alt text](./assets/img/start_jupyter_lab.png "Start the environment")


While your environment is starting,  [let's go to the next section.](step2.md)

## Navigation

<!-- startnav -->
* [Red Hat OpenShift Data Science Workshop - FSI Credit Fraud Detection](index.md)
* [Step 1: Starting a Jupyter environment](step1.md)**<-- you are here**
* [Step 2: The Jupyter environment](step2.md)
* [Step 3: Notebooks](step3.md)
* [Step 4: FSI Credit Fraud Detection](step4.md)
* [Conclusion](step8.md)
<!-- endnav -->
