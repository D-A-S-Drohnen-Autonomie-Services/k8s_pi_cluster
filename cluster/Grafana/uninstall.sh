#!/bin/bash
helm uninstall grafana --namespace grafana
kubectl delete namespace grafana