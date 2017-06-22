#!/usr/bin/env bash

# Only run the following if this is the first time running
if [ ! -f /var/log/firsttime ]; then
    touch /var/log/firsttime
    sudo apt-get update

    # Set root password
    sudo apt-get install debconf-utils -y > /dev/null 2>&1
    sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password password"
    sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password password"

    # Install mysql
    sudo apt-get install mysql-server -y > /dev/null 2>&1

    # Adjust bind-address
    sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf

    # Allow remote access
    mysql -u root -ppassword -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;"

    # Create ghost db
    mysql -u root -ppassword -e "CREATE DATABASE ghost;"

    # Import database
    mysql -u root -ppassword ghost < /vagrant/ghost.dump

    # Create ghost user
    mysql -u root -ppassword -e "CREATE USER 'ghost'@'0.0.0.0' IDENTIFIED by 'XXXX';"
    mysql -u root -ppassword -e "CREATE USER 'ghost'@'%' IDENTIFIED by 'XXXX';"

    # Grant permissions to ghost database
    mysql -u root -ppassword -e "GRANT ALL ON *.* to 'ghost'@'0.0.0.0';"
    mysql -u root -ppassword -e "GRANT ALL ON *.* to 'ghost'@'%';"

    # Flush privileges
    mysql -u root -ppassword -e "FLUSH PRIVILEGES;"

    # Restart
    sudo systemctl restart mysql.service

    # Enable and start
    sudo systemctl enable mysql.service
    sudo systemctl start mysql.service
fi
