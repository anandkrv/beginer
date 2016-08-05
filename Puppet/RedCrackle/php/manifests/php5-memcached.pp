class php::php5-memcached {
package { "php5-memcached":
    require => Class['php'],
    ensure => "installed",
}
}
