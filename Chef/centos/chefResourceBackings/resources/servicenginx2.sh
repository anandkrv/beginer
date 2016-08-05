sudo chef-apply -l info -e "service 'nginx' do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end"
