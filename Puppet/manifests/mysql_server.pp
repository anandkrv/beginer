#Use this command to install Mysql
puppet module install puppetlabs-mysql

#install mysql server
#include '::mysql::server'

#install mysql server and give root password
class { '::mysql::server':
  root_password    => 'pass',
  override_options => $override_options
#Create database
       databases =>
       {'alok' => {
    ensure  => 'present',
    charset => 'utf8',
  },
}
}

#Creates a database with a user and assigns some privileges
mysql::db { 'alok':
  user     => 'alok',
  password => 'alok',
  host     => 'localhost',
 grant    => ['SELECT', 'UPDATE'],
}

#mysql_user can be used to create and manage user grants within MySQL.
mysql_user { 'alok@127.0.0.1':
 ensure                   => 'present',
  max_connections_per_hour => '0',
  max_queries_per_hour     => '0',
 max_updates_per_hour     => '0',
  max_user_connections     => '0',
}
#mysql_grant can be used to create grant permissions
mysql_grant { 'root@localhost/*.*':
  ensure     => 'present',
  options    => ['GRANT'],
  privileges => ['ALL'],
  table      => '*.*',
  user       => 'root@localhost',
}

