#!/bin/bash

cd /tmp
wget --no-check-certificate https://packages.chef.io/stable/el/6/chef-server-core-12.8.0-1.el6.x86_64.rpm

hostname chef-server
systemctl stop firewalld
yum -y install net-tools
sudo echo "127.0.0.1 chef-server chef-server" >> /etc/hosts
rpm -Uvh chef-server-core-12.8.0-1.el6.x86_64.rpm

mkdir /data

chef-server-ctl reconfigure
chef-server-ctl user-create sandy Sandeep Rawat sandeep@opstree.com 'sandy724' --filename /data/sandy.pem
chef-server-ctl org-create opstree 'Opstree Solutions' --association_user sandy --filename /data/opstree-validator.pem

chef-server-ctl install chef-manage
chef-server-ctl reconfigure
chef-manage-ctl reconfigure --accept-license
