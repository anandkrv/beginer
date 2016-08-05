class php::php5-gd {
package { "php5-gd":
    require => Class['php'],
    ensure => "installed",
}
}
