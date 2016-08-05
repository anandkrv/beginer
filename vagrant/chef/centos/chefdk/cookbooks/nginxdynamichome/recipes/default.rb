#
# Cookbook Name:: nginxdynamichome
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "/usr/share/nginx/html/index.html" do
  source 'index.html.erb'
  variables(
    :servername => "#{node['nginx']['servername']}"
  )
end

