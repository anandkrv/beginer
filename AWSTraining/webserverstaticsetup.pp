class { 'nginx': }

nginx::resource::vhost { 'static.example.com':
  www_root => '/var/www/static.example.com',
}

