#!/bin/bash
# Install microk8s
snap install microk8s --classic
# Update user permissions
usermod -a -G microk8s $USER
mkdir ~/.kube
chown -R $USER ~/.kube
microk8s status
microk8s add-node
