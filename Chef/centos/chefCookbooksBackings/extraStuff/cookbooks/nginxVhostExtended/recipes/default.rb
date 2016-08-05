#
# Cookbook Name:: nginxVhostExtended
# Recipe:: default
#
# Copyright 2016, Saurabh Vajpayee
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
