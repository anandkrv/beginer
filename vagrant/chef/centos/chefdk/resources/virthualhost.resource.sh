sudo chef-apply -l info -e "directory '/usr/share/nginx/chef'"
sudo chef-apply -l info -e "file '/usr/share/nginx/chef/index.html' do content 'Hello from chef server' end"
sudo chef-apply -l info -e "file '/etc/nginx/conf.d/chef.xebia.com.conf' do content IO.read('/vagrant/resources/chef.xebia.com.conf') end"
sudo chef-apply  -e "service 'nginx' do action [:stop, :start] end"
