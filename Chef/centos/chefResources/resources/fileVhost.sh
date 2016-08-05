sudo chef-apply -l info -e "file '/etc/nginx/conf.d/blog.opstree.com.conf' do content IO.read('/vagrant/resources/blog.opstree.com.conf') end"
sudo chef-apply -l info -e "file '/etc/nginx/conf.d/chef.opstree.com.conf' do content IO.read('/vagrant/resources/chef.opstree.com.conf') end"
