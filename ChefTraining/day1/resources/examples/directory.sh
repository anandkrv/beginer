sudo chef-apply -l info -e "directory '/tmp/chef'"

sudo chef-apply -l info -e "directory '/tmp/chef/test/test1' do
  owner 'root'
  group 'root'
  mode '0700'
  recursive true
  action :create
end"

sudo chef-apply -l info -e "directory '/tmp/chef/test' do
  recursive true
  action :delete
end"
