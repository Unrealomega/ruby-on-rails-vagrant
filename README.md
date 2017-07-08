# Overview

A simple vagrant development file and scripts to deploy a Ruby on Rails local instance. Just open up a command prompt in the same folder and run **vagrant up**. It should build out a instance as well as start the server for you.

Once you have deployed it locally, update the database config's password under **rails-root\config\database.yml**. After that, make sure to SSH into virt and run **rake db:create** within the rails-root folder to create the Database.

# Troubleshooting

## My rails code isn't updating!

This is a known issue with Vagrant. You can address this by going into your **config/environments/development.rb** and adding/modifying the line below:

```
config.file_watcher = ActiveSupport::FileUpdateChecker
```