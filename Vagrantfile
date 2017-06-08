# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/xenial64"
    config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.hostname = "ghost1"
    config.vm.provision "shell", path: ".provision/bootstrap.sh"

    config.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
    end
end
