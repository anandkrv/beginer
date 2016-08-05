#
# Cookbook Name:: nginxVhost
# Recipe:: default
#
# Copyright 2016, Saurabh Vajpayee
#

package 'epel-release' do
 action :install
end

package 'nginx' do
 action :install
end

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


template "#{node['nginx']['webroot']}/index.html" do
  source 'index.html.erb'
  variables(
    :servername => "#{node['nginx']['servername']}"
  )
end

line = "127.0.0.1 #{node['nginx']['servername']}"
 file = Chef::Util::FileEdit.new('/etc/hosts')
 file.insert_line_if_no_match(/#{line}/, line)
 file.write_file

service 'iptables' do
  action :stop
end

service 'nginx' do
 action :restart
end
