# == Class: percona
#
# Full description of class percona here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'percona':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class percona (
$wsrep_node_name = "",
$wsrep_node_address = "",
$wsrep_cluster_name = "",
$wsrep_cluster_address = "",
$wsrep_slave_threads = 4,
$wsrep_sst_method = "xtrabackup-v2",
$wsrep_sst_auth = "sst:secret", 
){
 

                   

   #    exec {"import Percona key":
    #                               path => ['/bin', '/usr/bin'],
    #                               command => "apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A ",
                                 #  unless => "apt-key export CD2EFD2A  2>/dev/null | gpg - 2>/dev/null > /dev/null",
     #        }





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


        file {'percona.list':
                         path    => '/etc/apt/sources.list.d/percona.list',
                         ensure  => present,
                         mode    => 0640,
                         content => 'deb http://repo.percona.com/apt precise main
deb-src http://repo.percona.com/apt precise main ', 
                         notify  => Exec['apt_update'],           

  }
            

    #     exec {'create_perconalist':
     #                        command => "echo 'deb http://repo.percona.com/apt precise main' >> /etc/apt/sources.list.d/percona.list && echo 'deb-src http://repo.percona.com/apt precise main' >> /etc/apt/sources.list.d/percona.list ",
      #                       notify  => Exec['apt_update'],
       #       }      


        exec {'apt_update':
                           command => "apt-get update",
                           refreshonly => true,
             }

        $required_pkg = [ "percona-xtradb-cluster-56", "qpress", "xtrabackup", "python-software-properties", "vim", "wget", "curl", "netcat" ]


        package { $required_pkg:
                               ensure => "installed"
                }

        file {'my.cnf':
                         path => '/etc/mysql/my.cnf',
                         ensure  => present,
                         content => template('percona/my.cnf.erb'),
             }

       
        service {'mysql':
                         ensure => running, 
                         enable => true,
                         require => [Package[$required_pkg],File['my.cnf']],
                }

    
        exec{'sst_user':   
                   command => "mysql -e \"GRANT RELOAD, LOCK TABLES, REPLICATION CLIENT ON *.* TO 'sst'@'localhost' IDENTIFIED BY 'secret';\"",
                   require => Service['mysql']
        }


}
