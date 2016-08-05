sudo chef-apply -l info -e "package 'tar' do
  version '1.26-29.el7'
  action :install
end"
