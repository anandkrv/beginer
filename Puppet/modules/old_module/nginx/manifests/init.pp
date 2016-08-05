class nginx {
package { 'nginx':
  require => Exec['apt-update'],        
  ensure => installed,
}
service { 'nginx':
  ensure => running,
}
}

