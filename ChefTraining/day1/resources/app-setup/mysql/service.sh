sudo chef-apply -l info -e "service 'mysqld' do action [:stop, :start] end"
