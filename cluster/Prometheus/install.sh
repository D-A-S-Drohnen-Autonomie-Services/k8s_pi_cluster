#!/bin/bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm install prometheus-kube-cluster prometheus-community/kube-prometheus-stack --version 54.2.2 -f values-kube.yaml --create-namespace --namespace kube-prometheus
helm install prometheus-app-cluster prometheus-community/prometheus --version 25.8.0 -f values-app.yaml --create-namespace --namespace prometheus