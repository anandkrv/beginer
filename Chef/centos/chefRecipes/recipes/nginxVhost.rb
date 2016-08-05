directory '/usr/share/nginx/blog' do
  recursive true
end

directory '/usr/share/nginx/chef' do
  recursive true
end

file  '/usr/share/nginx/blog/index.html' do 
  content '<html><title>Chef Session</title><body><h1>Hello this is Blog from Opstree !!</h1></body></html>' 
end

file  '/usr/share/nginx/chef/index.html' do 
  content '<html><title>Chef Session</title><body><h1>Hello this is Chef Opstree !!</h1></body></html>' 
end

file '/etc/nginx/conf.d/blog.opstree.com.conf' do 
  content IO.read('/vagrant/recipes/blog.opstree.com.conf') 
end

file '/etc/nginx/conf.d/chef.opstree.com.conf' do 
  content IO.read('/vagrant/recipes/chef.opstree.com.conf') 
end

service 'nginx' do 
  action [:stop, :start] 
end

