#!/bin/bash

# Install postgres
POSTGRES=$(dpkg-query -W postgresql | grep postgresql)
if [ -z $POSTGRES ]; then
	sudo apt-get update
	sudo apt-get install -y postgresql postgresql-contrib
else
	echo "Postgres already installed"
fi

# Create a linux user
USER_PRESENT=$(cat /etc/passwd | grep mrserver)
if [ -z $USER_PRESENT ]; then
	sudo adduser --system --no-create-home --group mrserver
else
	echo "mrserver already created"
fi

# Setup postgres
sudo chmod +x /vagrant/postgres.sh
sudo su - postgres /vagrant/postgres.sh

# Restart postgres
sudo /etc/init.d/postgresql restart