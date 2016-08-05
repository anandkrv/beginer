bash 'Download mysql repo' do
 user 'root'
 cwd '/tmp'
 code <<-EOH
 wget  http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm 
 EOH
end

rpm_package '/tmp/mysql-community-release-el7-5.noarch.rpm' do
  action :install
end

execute 'yum update' do
 command 'echo y | yum update --skip-broken'
end
sudo chef-apply -l info -e "package 'mysql-server'"
