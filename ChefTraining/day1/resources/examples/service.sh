sudo chef-apply -l info -e "service 'crond' do action [:stop, :start] end"
