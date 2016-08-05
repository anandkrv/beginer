sudo chef-apply -l info -e "link '/tmp/myhardfile' do
  to '/etc/ssh/sshd_config'
  link_type :hard
end"
