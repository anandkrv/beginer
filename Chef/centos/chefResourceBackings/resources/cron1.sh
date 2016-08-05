sudo chef-apply -l info -e "cron 'noop' do
  hour '5'
  minute '0'
  command '/bin/true'
end"
