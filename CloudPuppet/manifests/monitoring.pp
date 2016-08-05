class{ '::java': 
	distribution => "jre",
}->
class { 'redis': 
	listen => "0.0.0.0"
}->
class { 'elasticsearch':
  	package_url => 'https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/rpm/elasticsearch/2.1.1/elasticsearch-2.1.1.rpm',
    notify => Exec["elasticsearch service start"],
}->

class { 'logstash':
  	manage_repo  => true,
  	repo_version => '2.1',
}->
class { 'kibana': 
	version => '4.3.1',
	bind => '0.0.0.0'
}->
class { 'pip': }->
class { 'beaver': 
	status => enabled,
}
beaver::input::file{ "syslog":
	file => '/var/log/messages',
	type => 'syslog'
}
beaver::output::redis{ 'redisout':
	host =>'172.31.0.30',
	port => '6379',
}

logstash::configfile { 'input_redis':
  template => 'logstash/input_redis.erb',
  order    => 10,
}
logstash::configfile { 'output_es':
  template => 'logstash/output_es_cluster.erb',
  order   => 30,
}
/*
exec { "logstash service start":
    command => "/bin/bash -c \"service logstash restart\"",
    path    => ['/bin', '/usr/bin', '/sbin', '/usr/sbin/'],
    require => Class["logstash"]
}

exec { "kibana start":
    command => "/bin/bash -c \"sleep 10\" && \"service kibana restart\"",
    path    => ['/bin', '/usr/bin', '/sbin', '/usr/sbin/'],
    require => Class["kibana","elasticsearch"]
}
*/
exec { "elasticsearch service start":
    command => "/bin/bash -c \"service elasticsearch restart\"",
    path    => ['/bin', '/usr/bin', '/sbin', '/usr/sbin/'],
    #require => Class["elasticsearch"]
}
include apache
include apache::mod::php
class { 'mysql::server': }
class { 'zabbix': 
	zabbix_version => 2.4,
}
class { 'zabbix::agent': 
  server => "172.31.0.30",
  serveractive => "172.31.0.30",
}


