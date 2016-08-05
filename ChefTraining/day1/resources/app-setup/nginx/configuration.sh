sudo chef-apply -l info -e "file '/etc/nginx/nginx.conf' do content IO.read('./nginx.conf') end"
sudo chef-apply -l info -e "file '/etc/nginx/conf.d/ciapp.conf' do content IO.read('./ciapp.conf') end"
