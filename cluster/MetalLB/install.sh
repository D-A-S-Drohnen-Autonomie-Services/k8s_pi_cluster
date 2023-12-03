#!/bin/bash
#helm repo add metallb https://metallb.github.io/metallb
#helm install metallb metallb/metallb -f values.yaml --create-namespace --namespace metallb

helm install metallb oci://registry-1.docker.io/bitnamicharts/metallb -f values.yaml --create-namespace --namespace metallb