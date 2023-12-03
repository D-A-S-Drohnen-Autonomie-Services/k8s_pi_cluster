#!/bin/bash

helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install grafana grafana/grafana -f values.yaml --namespace grafana --create-namespace --set 'service.annotations.metallb\.universe\.tf\/loadBalancerIPs'="192.168.60.1"