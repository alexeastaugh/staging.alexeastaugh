# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/xenial64"

    # Setup webserver
    config.vm.define "web" do |web|
        web.vm.hostname = "web-ghost"
        web.vm.network "forwarded_port", guest: 80, host: 8080
        web.vm.provision "shell", path: ".provision/web_bootstrap.sh"

        config.vm.provider "virtualbox" do |vb|
            vb.memory = "1024"
            vb.name = "webserver-staging"
    end
end

    # Setup database
    config.vm.define "db" do |db|
        db.vm.hostname = "db-ghost"
        db.vm.network "private_network", type: "dhcp"
        web.vm.provision "shell", path: ".provision/db_bootstrap.sh"

        config.vm.provider "virtualbox" do |vb|
            vb.memory = "1024"
            vb.name = "db-staging"
    end
end
end
