#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install debconf-utils -y > /dev/null 2>&1

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password 1234"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password 1234"

sudo apt-get install mysql-server -y > /dev/null
