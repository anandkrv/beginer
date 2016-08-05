
file '/usr/share/nginx/html/index.html' do
  content '<html><title>Chef Session</title><body><h1>Hello Xebians !!</h1></body></html>'
  mode '0755'
  owner 'root'
  group 'root'
end

service 'iptables' do
  action :stop
end

service 'nginx' do
 action :restart
end
