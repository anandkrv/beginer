sudo chef-apply -l info  -e  "script 'install_something' do
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOH
  echo \"This content is inserted by Chef\" > test.txt 
  EOH
end"
