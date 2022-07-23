# Open Data Hub Workshop Setup Instructions

## Prerequisites
You'll need:
- An OpenShift 4.8 cluster - with admin rights. You can create one by following the instructions [here](http:/try.openshift.com), or via RHPDS (Red Hat staff only).
- the OpenShift command line interface, _oc_ available [here](https://docs.openshift.com/container-platform/4.6/cli_reference/openshift_cli/getting-started-cli.html)


## Download the Workshop Files

Using the example below:   
1. Clone (or fork) this repo.
2. Change directory into the root directory of the cloned repository **predictive-maint**.  
3. Create a variable *REPO_HOME* for this directory

```
git clone https://github.com/odh-labs/predictive-maint.git
cd predictive-maint
export REPO_HOME=`pwd`
```

## Install the Open Data Hub Operator

1. Log on to OpenShift as a Cluster Administrator. (For RHPDS this is opentlc-mgr.)
2. Click the *Perspective* dropdown list box
3. Click the *Administrator* perspective\
   OpenShift changes the user interface to the Adminstrator perspective.

<img src="./images/4-admin-setup/install-0.png" alt="drawing" width="200"/>

4. Click **Operators > Operator Hub**  
   OpenShift displays the operator catalogue.  
5. Click the *Filter by keybord* text box and type *open data hub*  
   OpenShift displays the *Open Data Hub Operator* tile.
6. Click the tile  
   OpenShift displays a Commmunity Operator warning dialog box.
7. Click **Continue**  
   OpenShift displays the operator details.
8. Click **Install**   
   OpenShift prompts for the operator configuration details.   
   <img src="./images/4-admin-setup/install-2.png" alt="drawing" width="500"/>  
9. Accept all defaults and click **Install**\
   OpenShift installs the operator and displays a diaglog box once complete.  
   <img src="./images/4-admin-setup/install-3.png" alt="drawing" width="500"/>
10. Click **View Operator**  
    OpenShift displays the operator details.   
   <img src="./images/4-admin-setup/install-4.png" alt="drawing" width="500"/>  

The Open Data Hub Operator is now installed. 