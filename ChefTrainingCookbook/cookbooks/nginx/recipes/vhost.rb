directory "/usr/share/nginx/#{node['nginx']['server']}"

template "/etc/nginx/conf.d/#{node['nginx']['server']}.conf" do
  source "vhost.erb"
end

template "/usr/share/nginx/#{node['nginx']['server']}/index.html" do
  source "vhostindex.erb"
end
