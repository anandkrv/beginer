sudo chef-apply -l info -e "script 'extract_module' do
  interpreter 'bash'
  cwd '/tmp'
  code <<-EOH
    mkdir -p /tmp/mytest
    touch /tmp/mytest/file.txt
    EOH
end"
