# == Class: memcached::config
class memcached::config {

  file { '/etc/default/memcached':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('memcached/default.erb'),
  }

  file { '/etc/memcached.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('memcached/memcached.conf.erb'),
  }

}
