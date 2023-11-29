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

You can use the output to config static ip addresses if you need to.

Notes:
- IPv4 and IPv6 information is displayed

## Step 2 [Single Server Config]

Configure the primary server with the K3S_TOKEN parameter.

```shell
export K3S_TOKEN={K3S_TOKEN}
sudo make step2
```

Expected output:

```text
[INFO]  systemd: Starting k3s
```

You can test your local installation by using the command:

```shell
k3s kubectl get no
```

The output should be similar to the following:

```shell
NAME          STATUS   ROLES                  AGE   VERSION
primarynode   Ready    control-plane,master   66s   v1.27.7+k3s2
```


## Step 3

Add the additional nodes from Step 2 if you have cancelled the command you can run the command again on the main server.

Execute the Step3 command:

```shell
export K3S_TOKEN={K3S_TOKEN}
export K3S_SERVER_IP={K3S_SERVER_IP}
sudo make step3
```

Once the request has been completed, go back to the server node [from step 2] and try the following command:

```shell
k3s kubectl get no
```

The output should be similar to the following:

```text
NAME          STATUS   ROLES                  AGE   VERSION
primarynode   Ready    control-plane,master   5m    v1.27.7+k3s2
node2         Ready    <none>                 12s   v1.27.7+k3s2
node1         Ready    <none>                 12s   v1.27.7+k3s2
```

Mission accomplished.