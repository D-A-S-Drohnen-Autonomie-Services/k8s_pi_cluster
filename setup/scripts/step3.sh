#!/bin/bash

# Install microk8s
snap install microk8s --classic
mkdir -p ~/.kube
usermod -a -G microk8s $USER
chown -R $USER ~/.kube