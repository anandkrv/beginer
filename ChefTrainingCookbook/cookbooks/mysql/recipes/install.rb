package 'mysql-server' do
 action :install
end

service 'mysqld' do
 action [ :enable, :start ]
end

template "/tmp/setrootpassword.sql" do
  source "setrootpassword.sql.erb"
end

bash 'change_password' do
  cwd '/tmp'
  code <<-EOF
  /usr/bin/mysql -u root -h 127.0.0.1 -P 3306  mysql < setrootpassword.sql
  EOF
  action :run
end
