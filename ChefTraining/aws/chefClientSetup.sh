#!/bin/bash

cd /tmp
wget --no-check-certificate  https://packages.chef.io/stable/el/6/chefdk-0.16.28-1.el6.x86_64.rpm
rpm -ivh chefdk-0.16.28-1.el6.x86_64.rpm

chef-apply -e "package ['git', 'vim', 'tree']"
