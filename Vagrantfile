# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.hostname = "ruby-vm"
    config.vm.network 'forwarded_port', guest: 3000, host: 3000
    config.vm.post_up_message = ""
    
    # Sync the time with host computer
    if Vagrant.has_plugin?("vagrant-timezone")
        timezone = "UTC"
    
        config.vm.post_up_message << "Timezone set to " << timezone << ". Please ensure this matches the time on your host machine, otherwise change this setting in Vagrant!"
        
        config.timezone.value = timezone
    else
        config.vm.post_up_message << "Make sure to install Timezone by running 'vagrant plugin install vagrant-timezone'."
    end
    
    # Install RVM and Ruby
    config.vm.provision :shell, path: "vagrant/install-rvm.sh", args: "stable", privileged: false
    config.vm.provision :shell, path: "vagrant/install-ruby.sh", args: "1.9.3", privileged: false
    config.vm.provision :shell, path: "vagrant/install-ruby.sh", args: "2.4.0 rails haml", privileged: false
    
    # Run our scripts
    config.vm.provision :shell, path: "vagrant/vagrant_install.sh"
    config.vm.provision :shell, path: "vagrant/vagrant_install_noroot.sh", privileged: false
    
    config.vm.define "prod", primary: true do |config|
        # Customization for Virtualbox (default provider)
        config.vm.provider :virtualbox do |vb|
            vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            vb.customize ["modifyvm", :id, "--memory", "1024"]

            # Comment the bottom two lines to disable muli-core in the VM
            vb.customize ["modifyvm", :id, "--cpus", "2"]
            vb.customize ["modifyvm", :id, "--ioapic", "on"]
            vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
            
            # Set the timesync threshold to 10 seconds, instead of the default 20 minutes.
            vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]
        end
        
        # Run this every time we reboot
        config.vm.provision :shell, path: "vagrant/vagrant_run_always_noroot.sh", args: 'production', run: 'always', privileged: false
    end
    
    config.vm.define "dev", primary: true do |config|
        # Customization for Virtualbox (default provider)
        config.vm.provider :virtualbox do |vb|
            vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            vb.customize ["modifyvm", :id, "--memory", "1024"]

            # Comment the bottom two lines to disable muli-core in the VM
            vb.customize ["modifyvm", :id, "--cpus", "2"]
            vb.customize ["modifyvm", :id, "--ioapic", "on"]
            vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
            
            # Set the timesync threshold to 10 seconds, instead of the default 20 minutes.
            vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]
        end
        
        # Run this every time we reboot
        config.vm.provision :shell, path: "vagrant/vagrant_run_always_noroot.sh", args: 'development', run: 'always', privileged: false
    end
    
    config.vm.synced_folder "./src/", "/var/www/vagrant/"
    
    if not Vagrant.has_plugin?("vagrant-vbguest")
        config.vm.post_up_message = config.vm.post_up_message << "\en" << "Make sure to install VBGuest by running 'vagrant plugin install vagrant-vbguest'."
    end
end
