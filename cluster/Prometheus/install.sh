#!/bin/bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm install kube-prometheus prometheus-community/kube-prometheus-stack --version 54.2.2 -f values-kube.yaml --create-namespace --namespace kube-prometheus --set 'prometheus.service.type'=LoadBalancer --set 'prometheus.service.annotations.metallb\.universe\.tf\/loadBalancerIPs'=192.168.60.2
#helm install prometheus-app-cluster prometheus-community/prometheus --version 25.8.0 -f values-app.yaml --create-namespace --namespace prometheus