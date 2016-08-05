package 'mysql-server' do
 action :install
end

service 'mysqld' do
 action [ :enable, :start ]
end

bash 'change_password' do
  code <<-EOF
  /usr/bin/mysql -u root -h 127.0.0.1 -P 3306  mysql < setrootpassword.sql
  EOF
  action :run
end

bash 'create database' do
  code <<-EOF
  echo 'CREATE DATABASE employeedb;' | /usr/bin/mysql -u root -h 127.0.0.1 -P 3306 -ppassword
  EOF
  not_if "/usr/bin/mysql -u root -h 127.0.0.1 -P 3306 -ppassword -e 'show databases' | grep employeedb"
  action :run
end


service 'mysqld' do
 action [ :stop, :start ]
end

