sudo chef-apply -l info -e "package [ 'git', 'vim' ] do
 action :install
end"
