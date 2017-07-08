#!/bin/bash

export app_base=/var/www
export www_base=$app_base/vagrant

export PROJECT_VERSION=$1
export DBPASS='CHANGEME'

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
apt-get install -y curl nodejs git debconf-utils

#
# MySQL installation
#
debconf-set-selections <<< 'mysql-server mysql-server/root_password password $DBPASS'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password $DBPASS'
apt-get install -y mysql-server mysql-client libmysqlclient-dev # MySQL

# Set this as the default directory
echo "cd $www_base" >> /etc/bash.bashrc

# Update RAILS_ENV to reduce the amount of RAILS_ENV we have to use
echo "export RAILS_ENV=$PROJECT_VERSION" >> /etc/bash.bashrc