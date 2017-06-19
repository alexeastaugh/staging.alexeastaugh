#!/usr/bin/env bash

# Only run the following if this is the first time running
if [ ! -f /var/log/firsttime ]; then
    touch /var/log/firsttime
    sudo apt-get update

    # Get the latest version of Node
    sudo apt-get -y install python-software-properties python g++ make
    sudo add-apt-repository ppa:chris-lea/node.js
    sudo apt-get update
    sudo apt-get -y install nodejs nodejs-legacy npm

    # Install NGINX
    sudo apt-get -y install nginx
    sudo systemctl enable nginx.service
    sudo systemctl start nginx.service
    
    # Setup NGINX
    sudo cp /vagrant/.provision/nginx/ghost /etc/nginx/sites-available/ghost
    sudo chmod 644 /etc/nginx/sites-available/ghost
    sudo ln -s /etc/nginx/sites-available/ghost /etc/nginx/sites-enabled/ghost
    sudo systemctl restart nginx.service

    # Download and unzip Ghost
    sudo mkdir /var/www
    sudo mkdir /var/www/ghost
    cd /var/www/ghost
    sudo apt-get install unzip
    wget https://github.com/TryGhost/Ghost/releases/download/0.11.9/Ghost-0.11.9.zip
    unzip Ghost-0.11.9.zip

    # Update config with correct URL
    cp config.example.js config.js
    sed -i 's/127.0.0.1/0.0.0.0/g' config.js
    sed -i 's/my-ghost-blog.com/staging.alexeastaugh.com/g' config.js

    # Install Ghost
    sudo npm install --production
fi

# Run via system unit file
if [ ! -f /etc/systemd/system/ghost.service ]; then
    sudo cp /vagrant/.provision/services/ghost.service /etc/systemd/system/
    sudo systemctl enable ghost.service
    sudo systemctl start ghost.service
fi
