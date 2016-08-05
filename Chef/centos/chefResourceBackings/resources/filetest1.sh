sudo chef-apply -l info -e "file '/tmp/test.txt' do
  content 'This is testing file.'
  mode '0755'
  owner 'root'
  group 'root'
end"
