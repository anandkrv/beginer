# == Class: glus
#
# Full description of class glus here.
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
#  class { 'glus':
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
class glus (
$ip1 = "192.168.1.10",

$ip2 = "192.168.1.13",

$volume = "datapoint6",

$dirpath = "/repl-data6",

) {

package { 'glusterfs-server':
ensure => installed,
notify => Service[ 'glusterfs-server' ],
}

service { 'glusterfs-server':
  ensure => running,
  enable => true,
}

 exec { 'peer-probe':
 path => [
          '/usr/local/bin',
          '/opt/local/bin',
          '/usr/bin',
          '/usr/sbin',
          '/bin',
          '/sbin'],


 command => "gluster peer probe $ip2;gluster volume create $volume  replica 2 $ip1:$dirpath $ip2:$dirpath ;gluster volume start $volume",

 }

}
