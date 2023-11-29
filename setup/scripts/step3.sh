#!/bin/bash
# Install k3s as agent
curl -sfL https://get.k3s.io | K3S_URL=https://${K3S_SERVER_IP}:6443 K3S_TOKEN=${K3S_TOKEN} sh -