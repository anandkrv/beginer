#!/bin/bash

cd /tmp

wget --no-check-certificate  https://packages.chef.io/stable/el/6/chefdk-0.16.28-1.el6.x86_64.rpm

wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh epel-release-6-8.noarch.rpm

yum update -y
yum install -y tree vim

yum -y install docker-io
service docker start
chkconfig docker on

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
yum groupinstall -y 'development tools'
curl -L get.rvm.io | bash -s stable
source /etc/profile.d/rvm.sh
yum downgrade libyaml-0.1.3-4.el6_6
rvm --debug install 2.1.0
gem install bundler -v 1.11.2

echo "source 'https://rubygems.org'" > Gemfile
echo 'gem "test-kitchen", "1.5.0"' >> Gemfile
echo 'gem "kitchen-vagrant", "0.19.0"' >> Gemfile
echo 'gem "kitchen-docker", "2.3.0"' >> Gemfile
echo 'gem "docker", "0.3.1"' >> Gemfile

bundle install

gem list kitchen

kitchen init --driver=docker
