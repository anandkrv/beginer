# == Class: drupalserver
#
# Full description of class drupalserver here.
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
#  class { drupalserver:
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
class drupalserver($phpversion = '5.3.29', $path_deploy = "/usr/share/nginx/www") {
include locales
class { 'php':
  require => Class['locales'],
  php_version => "$phpversion",
}
include php::php5-mysql
include php::php-db
class{'memcached':
    listen_ip => '0.0.0.0'
}
include php::php5-memcached
include php::php5-gd
include php::drush
class { 'nginx':
   before => Class['nnginx'],
}
class { 'nnginx':
   drupal_root_path => "$path_deploy" 
}
class { 'mysql::client':}
include git
}
