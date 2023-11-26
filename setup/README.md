# Setup

This is the initial setup of the cluster. The script associated here will install basic software required to maintain the cluster in the long run.

It will output certain information into a file that is required for the cluster setup.

## Step 1

This is purely a configuration step, if you would like to configure networking and assign fixed ip addresses based off mac address information this step will give you the information you require.

First install make

```shell
sudo apt install make
```

Then run the `step1` from the setup folder.

```shell
sudo make step1
```


Notes:
- IPv4 and IPv6 information is displayed

## Step 2 [Single Server Config]

Configure the primary server.

```shell
sudo make step2
```

The output of the script should be similar to the following example:

```text
microk8s (1.28/stable) v1.28.3 from Canonical✓ installed
microk8s is not running. Use microk8s inspect for a deeper inspection.
From the node you wish to join to this cluster, run the following:
microk8s join 192.168.1.25:25000/5c34910f90dbe740222cb5cba123480f/a9ac531234ee

Use the '--worker' flag to join a node as a worker not running the control plane, eg:
microk8s join 192.168.1.25:25000/5c34910f90dbe740222cb5cba123480f/a9ac531234ee --worker

If the node you are adding is not reachable through the default interface you can use one of the following:
microk8s join 192.168.1.25:25000/5c34910f90dbe740222cb5cba123480f/a9ac531234ee
```

If you have lost the output above, you can always get it again with the following command:

```shell
microk8s add-node
```

Outputs the command that is needed to be run on Step 3. On each of the additional nodes, run step 3.

## Step 3

Add the additional nodes from Step 2 if you have cancelled the command you can run the command again on the main server.

Execute the Step3 command and then use the output from microk8s add-node


The final command can be extracted from step 2 the pattern is below:

```shell
microk8s join {PRIMARY_SERVER}:25000/{JOIN_CODE} --worker
```

An example:

```shell
microk8s join 192.168.1.25:25000/5c34910f90dbe740222cb5cba8298975/421c531441ee --worker
```

