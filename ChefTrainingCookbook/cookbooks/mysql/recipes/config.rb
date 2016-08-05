bash 'create database' do
  code <<-EOF
  echo "CREATE DATABASE #{node['mysql']['database']};" | /usr/bin/mysql -u root -h 127.0.0.1 -P 3306 -p#{node['mysql']['root_password']}
  EOF
  not_if "/usr/bin/mysql -u root -h 127.0.0.1 -P 3306 -p#{node['mysql']['root_password']} -e 'show databases' | grep #{node['mysql']['database']}"
  action :run
end
