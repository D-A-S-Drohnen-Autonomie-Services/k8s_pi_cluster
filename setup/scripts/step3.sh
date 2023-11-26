#!/bin/bash

# Install microk8s
snap install microk8s --classic
mkdir -p ~/.kube
sudo usermod -a -G microk8s $USER
sudo chown -R $USER ~/.kube