#
# Cookbook Name:: nginxhome
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file '/usr/share/nginx/html/index.html' do 
  source 'index.html'
  owner 'root'
  group 'root'
end
