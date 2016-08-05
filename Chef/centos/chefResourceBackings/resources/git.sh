sudo chef-apply -l info -e "directory '/opt/test'"
sudo chef-apply -l info -e "git '/opt/test' do
  destination '/opt/test'
  repository 'https://github.com/OpsTree/Chef.git'
  revision 'master'
  action :sync
end"
