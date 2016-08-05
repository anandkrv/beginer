sudo chef-apply -l info -e "service 'nginx' do action [:stop, :start] end"
