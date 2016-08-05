#
# Cookbook Name:: nginx-centos
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'nginxcentos'

node['nginx']['vhost'].each do |name, attrs|
  nginxcentos_vhost 'name' do
    port attrs['port']
    webroot attrs['webroot']
    servername attrs['servername']
    conffile attrs['conffile']
  end
end

service 'nginx' do
 action :restart
end
