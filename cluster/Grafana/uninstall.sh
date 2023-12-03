#!/bin/bash
helm uninstall grafana grafana/grafana --namespace grafana
kubectl delete namespace grafana