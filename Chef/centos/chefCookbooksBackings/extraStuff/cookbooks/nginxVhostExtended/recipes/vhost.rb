#
# Cookbook Name:: nginxVhostExtended
# Recipe:: vhost
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#
include_recipe 'nginxVhostExtended'

node['nginx']['vhost'].each do |name, attrs|
  nxVhostExtended_vhost 'name' do
    port attrs['port']
    webroot attrs['webroot']
    servername attrs['servername']
    conffile attrs['conffile']
  end
end

service 'nginx' do
 action :restart
end
