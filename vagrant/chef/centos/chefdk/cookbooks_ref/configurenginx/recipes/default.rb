#
# Cookbook Name:: configurenginx
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#

directory '/usr/share/nginx/blog2'

template '/usr/share/nginx/blog2/index.html' do
  source 'index.html.erb'
  variables(
    :sitename => "blog2"
  )
end



template '/etc/nginx/conf.d/blog2.xebia.com.conf' do
  source 'chefmanagedconf.conf.erb'
  variables(
    :port => "80",
    :servername => "blog2.xebia.com",
    :webroot => "/usr/share/nginx/blog2"
  )
end


service 'iptables' do
  action :stop
end

service 'nginx' do 
  action [:stop, :start] 
end

