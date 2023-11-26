# Information
This is a general Loadbalancer for Bare Metal environments.

# Install

## Using helm

Add Repo

```shell
helm repo add metallb https://metallb.github.io/metallb
```

Install chart with some values.

```shell
helm install metallb metallb/metallb -f values.yaml --create-namespace --namespace metallb
```
