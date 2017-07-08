#!/bin/bash
# Using Trusty64 Ubuntu

export app_base=/var/www
export www_base=$app_base/vagrant
export rails_root=$www_base/rails-root

export PROJECT_VERSION=$1

# Check if we're in production and $SECRET_KEY_BASE has not been set
if [ $PROJECT_VERSION = 'production' ] && [ -z "$SECRET_KEY_BASE" ]; then
    echo "Server is in Production and \$SECRET_KEY_BASE has not been set."
    echo "Please update this environmental value and reboot the server after setting this environmental value with \"vagrant reload\"."
    
    exit 1
fi

# If rails-root doesn't exist, create it and generate a source
if [ ! -d $rails_root ]; then
    echo No rails-root. Generating one.
    
    cd $www_base
    
    rails new rails-root -d mysql
fi

cd $rails_root

echo SYNCING TIME
ntpdate -s time.nist.gov

echo STARTING SERVER

#
# Run a bundle update to ensure all gems are present
#
bundle update

echo Started server in $PROJECT_VERSION mode

#
# Start the rails server
#
rails s -b 0.0.0.0 -d -e $PROJECT_VERSION

if [ $PROJECT_VERSION = 'development' ]; then
    echo "If this your first time deploying this, make sure to ssh into the virt and run \"rake db:create\" within the rails-root folder to create the DB"
fi

exit 0