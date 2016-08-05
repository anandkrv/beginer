
#use puppetlabs-mysql module from puppet forge

#run this command to install puppet mysql module
puppet module install puppetlabs-mysql


# this will set saurabh as root password

class { '::mysql::server':
  root_password           => 'saurabh',
  override_options        => $override_options
}


#this will create a database named dbfirst with root user

mysql::db { 'dbfirst':
  user     => 'root',
  password => 'saurabh',
  host     => 'localhost',
  grant    => ['SELECT', 'UPDATE'],
}

