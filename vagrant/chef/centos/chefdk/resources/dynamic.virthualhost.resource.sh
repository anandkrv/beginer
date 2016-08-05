sudo chef-apply -l info -e "directory '/usr/share/nginx/domain1'"
sudo chef-apply -l info -e "file '/usr/share/nginx/domain1/index.html' do content 'Hello from domain1 server' end"
sudo chef-apply -l info -e "file '/etc/nginx/conf.d/domain1.xebia.com.conf' do content IO.read('/vagrant/resources/nginx.vh.erb') end"
sudo chef-apply  -e "service 'nginx' do action [:stop, :start] end"
