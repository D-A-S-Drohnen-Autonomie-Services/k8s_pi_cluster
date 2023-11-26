#!/bin/bash

# Install microk8s
snap install microk8s --classic
chown -R $USER ~/.kube
microk8s status