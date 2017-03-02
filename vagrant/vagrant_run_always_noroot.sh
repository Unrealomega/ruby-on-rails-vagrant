#!/bin/bash
# Using Trusty64 Ubuntu

export app_base=/var/www
export www_base=$app_base/vagrant
export rails_root=$www_base/rails-root

# If rails-root doesn't exist, create it and generate a source
if [ ! -d $rails_root ]; then
    echo No rails-root. Generating one.
    
    cd $www_base
    
    rails new rails-root
fi

cd $rails_root

echo STARTING SERVER

#
# Run a bundle update to ensure all gems are present
#
bundle update

#
# Start the rails server
#
rails s -b 0.0.0.0 -d