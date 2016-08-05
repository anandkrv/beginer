#
# Cookbook Name:: nginxvirtual
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package 'nginx'


directory "#{node['nginx']['webroot']}" do
  recursive true
end


template "/etc/nginx/conf.d/#{node['nginx']['conffile']}" do
  source 'chefmanagedconf.conf.erb'
  variables(
    :port => "#{node['nginx']['port']}",
    :servername => "#{node['nginx']['servername']}",
    :webroot => "#{node['nginx']['webroot']}"
  )
end


git "#{node['nginx']['webroot']}" do
   repository "#{node['nginx']['gitrepo']}"
   revision 'master'
   action :sync
end

service 'nginx' do
 action :restart
end
