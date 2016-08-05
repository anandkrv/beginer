class php::php-db {
package { "php-db":
    require => Class['php'],
    ensure => "installed",
}
}
