#!/bin/bash -v

# Add Custom key to Mongo version
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

# Update list packages
apt-get update -y
sudo apt-get install -y mongodb-org

# Add custom mongo configuration
sudo cp /tmp/mongod.conf /etc

sudo service mongod start
