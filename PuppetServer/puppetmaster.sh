#!/bin/bash -v

# HOSTNAME
sudo hostname puppet.example.com
sudo bash -c "echo \"puppet.example.com\" > /etc/hostname"
sudo bash -c "echo \"127.0.0.1 puppet.example.com\" >> /etc/hosts"

# NTP
sudo ntpdate pool.ntp.org

# Install PuppetMaster
wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
sudo dpkg -i puppetlabs-release-trusty.deb
sudo apt-get update -y
sudo apt-get install puppetmaster-passenger -y

# Stop Apache service
sudo service apache2 stop

# Create PuppetMaster Version Locking file
sudo bash -c "echo Package: puppet puppet-common puppetmaster-passenger > /etc/apt/preferences.d/00-puppet.pref"
sudo bash -c "echo Pin: version 3.8.6 >> /etc/apt/preferences.d/00-puppet.pref"
sudo bash -c "echo Pin-Priority: 501 >> /etc/apt/preferences.d/00-puppet.pref"

# Delete Old Certs
sudo rm -rf /var/lib/puppet/ssl

# Modifying puppet.conf
sudo sed -i '7 s/^/#/' /etc/puppet/puppet.conf
sudo sed -i '8i certname = puppet.example.com' /etc/puppet/puppet.com
sudo sed -i '9i dns_alt_names = puppet,puppet.example.com' /etc/puppet/puppet.conf

# Generating new Certs
bash -c "timeout 30 puppet master --verbose --no-daemonize"

# Create main Manifest file
sudo touch /etc/puppet/manifests/site.pp

# Start Apache
sudo service apache2 start

