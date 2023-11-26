#!/bin/bash

# Create working directory
mkdir ~/.k8s_setup
# Install networking tools incase not present and raspi for ubuntu
apt install -y net-tools linux-modules-extra-raspi
# Get ip address
ifconfig | awk '/inet / {print $2}' | awk '!($1=="127.0.0.1")' | awk '{ print "IPv4 address: " $1}' > ~/.k8s_setup/config.output
ifconfig | awk '/inet6 / {print $2}' | awk '!($1=="::1")' | awk '{ print "IPv6 address: " $1}' >> ~/.k8s_setup/config.output
ifconfig | awk '/ether / {print $2}' | awk '{ print "MAC: " $1}' >> ~/.k8s_setup/config.output

echo "Network config:"
cat ~/.k8s_setup/config.output

if [ -z $(awk '/cgroup_memory=/ {print $1}' /boot/cmdline.txt) ]
then
  echo ' cgroup_memory=1 cgroup_enable=memory' >> /boot/cmdline.txt
  echi 'Added CGroup configuration'
fi
