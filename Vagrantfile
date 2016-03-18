# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  # 
  # IoT Hub specific: you can either use this public base box, or create your own
  # and use that instead. Currently tested with Debian 7, OpenJDK 7 should be installed.
  # The packer template included in this repo can be used to create a custom box.
  config.vm.box = "jphire/galileo-base"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "jphire/galileo-base"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo apt-get update
  #   sudo apt-get install -y apache2
  # SHELL

  # Enable berkshelf plugin, should only be used if cookbook dependencies 
  # need to be fetched.
  # config.berkshelf.enabled = true

  # config.vm.provision "shell", path: "setup.sh"
  # config.vm.network "private_network", type: "dhcp"

  # Start 4 hubs by default, but users are free to add/remove VMs as they like. 
  config.vm.define :hub1 do |hub|
    hub.vm.network :forwarded_port, guest: 8080, host: 9001
    hub.vm.hostname = "hub1"
    # hub.vm.synced_folder "/Users/jphire/Code/java_projects/kahvihub/", "/home/vagrant/kahvihub"
    hub.vm.network :private_network, ip: "192.168.56.101"
    hub.vm.provision :shell, path: "scripts/setup-iothub.sh"
  end

  config.vm.define :hub2 do |hub|
    #hub.vm.box = "jphire/galileo-base"
    hub.vm.network :forwarded_port, guest: 3000, host: 9002
    hub.vm.hostname = "hub2"
    hub.vm.network :private_network, ip: "192.168.56.102"
    hub.vm.provision :shell, path: "scripts/setup-nodehub.sh"
  end

  config.vm.define :hub3 do |hub|
    hub.vm.network :forwarded_port, guest: 3030, host: 9003
    hub.vm.hostname = "hub3"
    hub.vm.synced_folder "/home/janne/Code/node-projects/node-test-server/", "/home/vagrant/node-test-server"
    hub.vm.network :private_network, ip: "192.168.56.103"
    hub.vm.provision :shell, path: "scripts/setup-duktapehub.sh"
  end

  config.vm.define :hub4 do |hub|
    hub.vm.network :forwarded_port, guest: 3000, host: 9004
    hub.vm.hostname = "hub4"
    hub.vm.synced_folder "/home/janne/Code/node-projects/node-iothub/", "/home/vagrant/node-iothub"
    hub.vm.network :private_network, ip: "192.168.56.104"
    hub.vm.provision :shell, path: "scripts/setup-node-iothub.sh"
  end
end
