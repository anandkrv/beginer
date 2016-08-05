sudo chef-apply -l info -e "bash 'change_password' do
  code <<-EOF
  /usr/bin/mysql -u root -h 127.0.0.1 -P 3306  < setrootpassword.sql
  EOF
  action :run
end"

sudo chef-apply -l info -e "bash 'create database' do
  code <<-EOF
  echo 'CREATE DATABASE employeedb;' | /usr/bin/mysql -u root -h 127.0.0.1 -P 3306 -ppassword;
  EOF
  not_if \"/usr/bin/mysql -u root -h 127.0.0.1 -P 3306 -ppassword -e 'show databases' | grep employeedb\"
  action :run
end"
