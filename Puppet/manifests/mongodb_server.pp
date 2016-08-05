#Use this command to install mongodb

puppet module install puppetlabs-mongodb

#run these command

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list

sudo apt-get update

#Install mongdb
include '::mongodb::server'


#install mongodb and change mongodb port
class {'::mongodb::server':
  port    =>27017,
  auth => true,
  verbose => true,
}
# create database 
mongodb_database { testdb:
  ensure   => present,
  tries    => 10,
  require  => Class['mongodb::server'],
}

# mongodb_user is used to create and manage users within MongoDB
mongodb_user { testuser:
  username      => 'testuser',
  ensure        => present,
  password_hash => mongodb_password('testuser', 'p@ssw0rd'),
  database      => testdb,
  roles         => ['readWrite', 'dbAdmin'],
  tries         => 10,
  require       => Class['mongodb::server'],
}

# Install MongoDB from 10gen repository
class {'::mongodb::globals':
  manage_package_repo => true,
}->
class {'::mongodb::server': }->
class {'::mongodb::client': }
