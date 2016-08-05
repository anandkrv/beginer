# == Class: memcached::package
class memcached::package {

  package { 'memcached':
    ensure => present,
  }

}
