sudo chef-apply -l info -e "file '/usr/share/nginx/blog/index.html' do content 'Hello from blog server' end"
sudo chef-apply -l info -e "file '/usr/share/nginx/chef/index.html' do content 'Hello from chef server' end"
