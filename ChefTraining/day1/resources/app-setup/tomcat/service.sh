sudo chef-apply -l info -e "service 'tomcat' do action [:stop, :start] end"
