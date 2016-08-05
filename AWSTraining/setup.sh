#!/bin/bash


sudo apt-get update -y
sudo apt-get -y install git

mkdir automation
cd automation
git clone https://github.com/OpsTree/AWSTraining.git

cd /tmp
wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
sudo dpkg -i puppetlabs-release-trusty.deb
sudo apt-get update
sudo apt-get install -y puppet

sudo git clone https://github.com/OpsTree/AWSTraining.git /etc/puppet/modules

sudo mkdir -p /var/www/static.example.com
cd /var/www/static.example.com
sudo git clone https://github.com/emicare/emicare.github.io.git .

sudo apt-get install -y awscli

echo "To setup nginx proxy webserver example.com"
echo "sudo puppet apply /etc/puppet/modules/webserversetup.pp"
echo "Note: Don't forget to give valid tomcat ip, and domain name"


echo "To setup nginx static webserver static.example.com"
echo "sudo puppet apply /etc/puppet/modules/webserverstaticsetup.pp"
echo "Note: You can modify the file to change the domain name if you wish"


echo "To setup tomcat webserver"
echo "sudo puppet apply /etc/puppet/modules/tomcatsetup.pp"
echo "Note: You can change the port on which you want tomcat to listen"

echo "To setup MySQL db"
echo "sudo puppet apply /etc/puppet/modules/dbsetup.pp"
echo "Note: You can change the passord of root user"
echo "Create database by logging in db (create database employeedb)"

echo "Copy the war to tomcat webapp folder as root context"
echo "cp Spring3HibernateApp.war /srv/tomcat/myapp/webapps/ROOT.war"
