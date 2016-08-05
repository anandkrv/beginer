#
# Cookbook Name:: nginx-centos
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'yum-epel'

package node['nginx']['packages'] do
 action :install
end

service 'iptables' do
 action :stop
end

service 'nginx' do
 action [:start, :enable]
end

