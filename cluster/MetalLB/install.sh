#!/bin/bash
helm repo add metallb https://metallb.github.io/metallb
helm install metallb metallb/metallb -f values.yaml --create-namespace --namespace metallb-system
kubectl apply -f kube.yaml -n metallb-system