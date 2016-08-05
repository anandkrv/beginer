class { 'java': }
class { 'tomcat': }
class { 'tomcat::instances': }->
class { 'ssh::jenkins_agent': }
class { 'mysql::server': }
class { 'mysql::dbs': }
class { 'sonarqube': }
include sudo
include sudo::configs
class { 'zabbix::agent': 
	server => "172.31.0.30",
	serveractive => "172.31.0.30",
}
class { 'pip': }->
class { 'beaver': 
  status => enabled,
}
beaver::input::file{ "syslog":
  file => '/var/log/messages',
  type => 'syslog'
}
beaver::input::file{ "tomcat":
  file => '/srv/tomcat/oracle/logs/*',
  type => 'tomcat'
}
beaver::output::redis{ 'redisout':
  host =>'172.31.0.30',
  port => '6379',
}