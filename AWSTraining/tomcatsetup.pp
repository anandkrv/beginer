class { 'java':
  distribution => 'jre',
}
include tomcat
tomcat::instance {'myapp':
  ensure      => present,
  http_port   => '8080',
}
