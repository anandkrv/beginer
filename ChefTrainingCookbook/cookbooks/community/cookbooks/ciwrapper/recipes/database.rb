mysql_service 'default' do
  initial_root_password 'password'
  action [:create, :start]
end

bash 'create databass' do
  code <<-EOF
  echo 'CREATE DATABASE employeedb;' | /usr/bin/mysql -u root -h 127.0.0.1 -P 3306 -ppassword;
  EOF
  not_if "sleep 10s; /usr/bin/mysql -u root -h 127.0.0.1 -P 3306 -ppassword -e 'show databases' | grep employeedb"
  action :run
end
