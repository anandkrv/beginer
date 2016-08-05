sudo chef-apply -l info -e "link '/tmp/myfile' do
  to '/etc/ssh/sshd_config'
end"	
