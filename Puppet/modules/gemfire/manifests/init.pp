# == Class: gemfire
#
# Full description of class gemfire here.
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
#  class { 'gemfire':
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
class gemfire {
  Exec {
    path => [
             '/usr/local/bin',
             '/opt/local/bin',
             '/usr/bin',
             '/usr/sbin',
             '/bin',
             '/sbin'],
             logoutput => true
  }
  package {"wget":
    ensure => 'installed',
  }

  exec {"add_key":
    command => "wget -q -O - http://packages.pivotal.io/pub/apt/ubuntu/DEB-GPG-KEY-PIVOTAL-APP-SUITE | apt-key add -",
    logoutput => true,
    require => Package["wget"]
  }
  
  exec {"download_repo_package":
    command => "wget -q -P /tmp http://packages.pivotal.io/pub/apt/ubuntu/pivotal-app-suite-repo-precise_1.0-5_all.deb",
    creates => "/tmp/pivotal-app-suite-repo-precise_1.0-5_all.deb",
    logoutput => true,
    require => Exec["add_key"]
  }

  exec {"install_repo_package":
    command => "dpkg -i /tmp/pivotal-app-suite-repo-precise_1.0-5_all.deb",
    creates => "/etc/apt/sources.list.d/pivotal-app-suite.list",
    logoutput => true,
    require => Exec["download_repo_package"]
  }
  
  exec {"sign_eula_update_apt_cache":
    command => "/etc/pivotal/app-suite/pivotal-eula-acceptance.sh --accept_eula_file=Pivotal_Software_EULA--8.4.14.txt",
    timeout => 1800,
    logoutput => true,
    require => Exec["install_repo_package"]
  }
  
  package {"pivotal-gemfire":
    ensure => 'installed',
    require => Exec["sign_eula_update_apt_cache"]
  }
  
  service {"cacheserver":
    ensure => 'running',
    require => Package['pivotal-gemfire'],
    hasstatus => false
  }

}
