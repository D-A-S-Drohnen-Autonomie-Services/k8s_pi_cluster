# Setup

This is the initial setup of the cluster. The script associated here will install basic software required to maintain the cluster in the long run.

It will output certain information into a file that is required for the cluster setup.

## Step 1

This is purely a configuration step, if you would like to configure networking and assign fixed ip addresses based off mac address information this step will give you the information you require.

Notes:
- IPv4 and IPv6 information is displayed

## Step 2 [Single Server Config]

Configure the primary server.

The final command:
```shell
microk8s add-node
```
Outputs the command that is needed to be run on Step 3. On each of the additional nodes

## Step 3

Add the additional nodes from Step 2 if you have cancelled the command you can run the command again on the main server
```shell
microk8s add-node
```


## Step 4

Configure additional worker nodes.

Parameters
- K3S_TOKEN
    - A secret token used to ensure `security between your nodes`
- PRIMARY_SERVER_IP
    - The IP Address of the primary server [From step 2]

