# Setup

## Setup Kubectl on your local environment

### Install kubectl
[Install kubectl](https://kubernetes.io/docs/tasks/tools/)

### Configure your local environment

On the primary server grab the config by running this command:

```shell
sudo cat /etc/rancher/k3s/k3s.yaml
```

Add the contents to your local kube configuration

- Linux
  - `~/.kube/config`

Grab config for cluster and move it to your local environment

## Install Helm

https://helm.sh/docs/intro/install/

