#!/bin/bash

helm uninstall kube-prometheus --namespace kube-prometheus
kubectl delete ns kube-prometheus