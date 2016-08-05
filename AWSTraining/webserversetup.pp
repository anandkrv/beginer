class { 'nginx': }
nginx::resource::upstream { 'tomcat_app':
  members => [
    '127.0.0.1:8080',
  ],
}
nginx::resource::vhost { 'example.com':
  proxy => 'http://tomcat_app',
}
