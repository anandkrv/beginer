# class "logstash" ensure installation of logstash

class logstash::install {
  
  # contain logstash binary name
  # Change value by your logstash version
  $logstash_binary = 'logstash-1.1.9-monolithic.jar'

  # Array containing a list of logstash directories
  $directories = ['/etc/logstash', '/etc/logstash/conf.d', '/usr/local/logstash', '/var/log/logstash']

  # If not exist, make directories of $directories
  file { $directories:
    ensure => directory,
    owner => root,
    group => root,
    mode => '0644',
  }

  # If not exist, deploy run script
  file { '/usr/bin/logstashd':
    ensure => present,
    source => 'puppet:///modules/logstash/logstashd',
    owner => root,
    group => root,
    mode => '0755',
  }

  # If not exist, deploy init script corresponding has $osfamily return
  file { '/etc/init.d/logstash':
    ensure => present,
    source => "puppet:///modules/logstash/logstash_init_${osfamily}",
    owner => root,
    group => root,
    mode => '0755',
  }

  # If not exist, deploy logstash binary
  file { '/usr/local/logstash/logstash.jar':
    ensure => present,
    source => "puppet:///modules/logstash/${logstash_binary}",
    owner => root,
    group => root,
    mode => '0755',
  }

  # If not exist, deploy logrotate configuration file
  file { '/etc/logrotate.d/logstash_rotate':
    ensure => present,
    source => 'puppet:///modules/logstash/logstash_rotate',
    owner => root,
    group => root,
    mode => '0644',
  }

  # If not exist, deploy logstash.log file
  file { '/var/log/logstash/logstash.log':
    ensure => present,
    owner => root,
    group => root,
    mode => '0664',
    require => File['/var/log/logstash'],
  }
}
