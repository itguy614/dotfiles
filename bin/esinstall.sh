#!/bin/sh

sudo apt-get update
sudo apt-get install openjdk-7-jre-headless -y

cd /tmp
sudo wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.1.deb
sudo dpkg -i elasticsearch-0.90.1.deb
sudo service elasticsearch start
