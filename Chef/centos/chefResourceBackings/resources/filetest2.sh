sudo chef-apply -l info -e "file '/tmp/test2.txt' do
  content IO.read('/vagrant/resources/string.txt')
  action :create
end"
