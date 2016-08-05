class percona::sstuser{

include percona

Exec {
path => [
'/usr/local/bin',
'/opt/local/bin',
'/usr/bin',
'/usr/sbin',
'/bin',
'/sbin'],
logoutput => true,
}

        exec{'sstuser':
                   command => "mysql -e \"GRANT RELOAD, LOCK TABLES, REPLICATION CLIENT ON *.* TO 'sst'@'localhost' IDENTIFIED BY 'secret';\"",
                   require => Service['mysql']
        }
}
