# == Class: memcached::service
class memcached::service {

  service { 'memcached':
    ensure => running,
  }

}
