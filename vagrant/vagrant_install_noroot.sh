#!/bin/bash
# Using Trusty64 Ubuntu

export app_base=/var/www
export www_base=$app_base/vagrant

export PROJECT_VERSION=$1

#
# Get the Gems!
#
gem install bundler