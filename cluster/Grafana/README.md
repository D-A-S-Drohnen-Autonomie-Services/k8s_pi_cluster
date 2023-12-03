# Grafana Setup

## Installation

Using helm just run the following:

```shell
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install grafana grafana/grafana -f values.yaml --namespace grafana --create-namespace
```