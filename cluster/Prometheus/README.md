# Information
This is a general installation of Prometheus for use with Grafana


# Setup

Add Repo

```shell
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
```

# Install - Kubernetes Monitoring

Install chart with some values.
```shell
helm install prometheus-kube-cluster prometheus-community/kube-prometheus-stack --version {VERSION} -f values-kube.yaml --namespace kube-prometheus
```
Example:

```shell
helm install prometheus-kube-cluster prometheus-community/kube-prometheus-stack --version 54.2.2 -f values-kube.yaml --create-namespace --namespace kube-prometheus
```

# Install - Application Stack

## Using helm


Install chart with some values.

```shell
helm install prometheus-app-cluster prometheus-community/prometheus --version {VERSION} -f values-app.yaml --namespace prometheus
```

Example:

```shell
helm install prometheus-app-cluster prometheus-community/prometheus --version 25.8.0 -f values-app.yaml --create-namespace --namespace prometheus
```