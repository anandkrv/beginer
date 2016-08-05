sudo chef-apply -l info -e "package 'tar' do
  action :remove
end"
