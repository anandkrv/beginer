# class "conf" provide configuration file for logstash


class logstash::conf {

  # Search base & individual configuration files
  # Restart logstash if necessary

  file {'/etc/logstash/conf.d/logstash_base.conf':
    ensure => present,
    source => ["puppet:///logstash/conf.d/logstash.${hostname}", 'puppet:///logstash/conf.d/logstash_base.conf'],
    owner => root,
    group => root,
    mode => '0644',
    links => follow,
    notify => Service['logstash'],
  }
}
