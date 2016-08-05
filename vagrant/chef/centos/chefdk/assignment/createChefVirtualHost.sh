sudo chef-apply -e "file '/etc/nginx/conf.d/blog.xebia.com.conf' do content IO.read('/vagrant/assignment/blog.virtualhost.cfg') end"
