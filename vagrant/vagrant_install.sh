#!/bin/bash

export app_base=/var/www
export www_base=$app_base/vagrant

export PROJECT_VERSION=$1

#
# Set Locacle
#
/usr/sbin/update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

#
# Add Vagrant user to the sudoers group
#
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

#
# Set up swap partition
#
echo Adding Swap File

fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap defaults 0 0' >> /etc/fstab

#
# Do a quick update
#
apt-get update

#
# Install requirements
#
apt-get install curl nodejs -y

# Set this as the default directory
echo "cd $www_base" >> /etc/bash.bashrc