
directory '/usr/share/nginx/blog'

file  '/usr/share/nginx/blog/index.html' do 
  content '<html><title>Chef Session</title><body><h1>Hello this is blog from Xebia !!</h1></body></html>' 
end

file '/etc/nginx/conf.d/blog.xebia.com.conf' do 
  content IO.read('/vagrant/recipes/blog.xebia.com.conf') 
end

service 'iptables' do
  action :stop
end

service 'nginx' do 
  action [:stop, :start] 
end
