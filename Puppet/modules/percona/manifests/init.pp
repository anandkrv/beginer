# == Class: percona
#
# Module for Percona XtraDB management.
#
# === Examples
#
#  class { percona:
#    wsrep_cluster_address => 'gcomm://192.168.0.1:4010,192.168.0.2:4010'
#  }
#
# === Authors
#
# Alessandro De Salvo <Alessandro.DeSalvo@roma1.infn.it>
#
# === Copyright
#
# Copyright 2013 Alessandro De Salvo
#
class percona (
  $mysql_version = "5.5",
  $root_password = undef,
  $old_passwords = false,                                                   
  $default_storage_engine = "InnoDB",
  $datadir = "/var/lib/mysql",
  $max_allowed_packet = "128M",
  $binlog_format = "ROW",
  $wsrep_provider = $percona::params::galera_provider,
  $wsrep_node_address = "192.168.1.2",
  $wsrep_cluster_name = "newcluster",
  $wsrep_cluster_address = "gcomm://",
  $wsrep_node_name = "cluster1",
  $wsrep_slave_threads = 4,
  $wsrep_sst_method = "xtrabackup-v2",
  $wsrep_sst_auth = "sst:secret" 
) inherits params {

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

    if ($percona::params::percona_compat_packages) {
        package { $percona::params::percona_compat_packages: require => $percona::params::percona_repo }
        $percona_server_req = Package[$percona::params::percona_compat_packages]
    } else {
        $percona_server_req = $percona::params::percona_repo
    }
    package { $percona::params::percona_galera_package:  require => $percona_server_req }
    package { $percona::params::percona_server_packages: require => Package[$percona::params::percona_galera_package] }
    package { $percona::params::percona_client_packages: require => Package[$percona::params::percona_server_packages] }
    
    file{"/tmp/kill_script_mysql.sh":
      content => template('percona/kill_mysql.sh.erb'),
      mode => 775,
      require => [Package[$percona::params::percona_server_packages],Package[$percona::params::percona_client_packages]]
    }

    exec{"kill_initial_mysql":
      command => "/tmp/kill_script_mysql.sh",
      creates => "/etc/mysql/my.cnf",
      returns => [""],
      require => File["/tmp/kill_script_mysql.sh"]
    }

    file {$percona::params::percona_conf:
        content => template('percona/my.cnf.erb'),
        require => Exec['kill_initial_mysql'],
    }

    file {$datadir:
        ensure => directory,
        owner  => mysql,
        group  => mysql,
        require => File[$percona::params::percona_conf],
    }

    service { $percona::params::percona_service:
        ensure => running,
        enable => true,
        hasrestart => true,
        require => File[$datadir],
    }

    if ($root_password) {
        exec {"set-percona-root-password":
            command => "mysqladmin -u root password \"$root_password\"",
            path    => ["/usr/bin"],
            onlyif  => "mysqladmin -u root status 2>&1 > /dev/null",
            require => Service [$percona::params::percona_service]
        }
    }
}
