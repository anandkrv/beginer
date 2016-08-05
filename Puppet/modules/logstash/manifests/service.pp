# class "service" ensures that logstash is started

class logstash::service {

  service {"logstash":
    ensure => running,
    enable => true,
    hasstatus => true,
    hasrestart => true,
    subscribe => [File["/usr/local/logstash/logstash.jar"], File["/usr/bin/logstashd"]],
    require => File["/etc/init.d/logstash"],
  }
}
