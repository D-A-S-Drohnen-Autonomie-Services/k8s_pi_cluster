#!/bin/bash
# Install microk8s
snap install microk8s --classic
microk8s status
microk8s add-node