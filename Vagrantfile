# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.hostname = "ruby-vm"
    config.vm.network 'forwarded_port', guest: 3000, host: 3000
    
    # Install RVM and Ruby
    config.vm.provision :shell, path: "vagrant/install-rvm.sh", args: "stable", privileged: false
    config.vm.provision :shell, path: "vagrant/install-ruby.sh", args: "1.9.3", privileged: false
    config.vm.provision :shell, path: "vagrant/install-ruby.sh", args: "2.4.0 rails haml", privileged: false
    
    # Run our scripts
    config.vm.provision :shell, path: "vagrant/vagrant_install.sh"
    config.vm.provision :shell, path: "vagrant/vagrant_install_noroot.sh", privileged: false
    
    # Run this every time we reboot
    config.vm.provision :shell, path: "vagrant/vagrant_run_always_noroot.sh", run: 'always', privileged: false
    
    config.vm.define "dev", primary: true do |config|
        # Customization for Virtualbox (default provider)
        config.vm.provider :virtualbox do |vb|
            vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            vb.customize ["modifyvm", :id, "--memory", "1024"]

            # Comment the bottom two lines to disable muli-core in the VM
            vb.customize ["modifyvm", :id, "--cpus", "2"]
            vb.customize ["modifyvm", :id, "--ioapic", "on"]
            vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
        end
    end
    
    config.vm.synced_folder "./", "/var/www/vagrant/"
    
    if not Vagrant.has_plugin?("vagrant-vbguest")
        config.vm.post_up_message = "Make sure to install VBGuest by running 'vagrant plugin install vagrant-vbguest'."
    end
end
