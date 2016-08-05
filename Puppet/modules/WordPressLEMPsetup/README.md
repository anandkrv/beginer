#These puppet module are used to setup wordpress with LEMP(Linux,nginx,mysql,php).
#This module is designed to fulfil the need of configuring wordpress with php7.
#Slight changes are made in wordpress module so that various wordpress instance can be 
#setup via hiera file.

#Hiera file to setup wordpress with php7 via Nginx.
########################################################################
php::repo::ubuntu::ppa: 'ondrej/php-7.0'

mysql::server::root_password: '$$$##@@@$$$'

wordpress::install_dir: '/opt/wordpress'
wordpress::version: '4.3.1'
wordpress::wp_owner: 'www-data'
wordpress::wp_group: 'www-data'
wordpress::db_user: '@dsnk@'
wordpress::db_password: '@cdnk@'

wordpress_newinstance:
  "site1":
    install_dir: '/opt/wordpressnew'
    version: '4.4.1'
    wp_owner: 'aman'
    wp_group: 'aman'
    db_name: "aman"
    db_user: '@dncjke@'
    db_password: '@dcjn@'

php::ensure: latest
php::manage_repos: true
php::fpm: true
php::dev: true
php::composer: true
php::pear: true
php::phpunit: false
php::fpm::config::log_level: notice
php::fpm::pools: 
  'www':
    listen: "/var/run/php/php7.0-fpm.sock"
    listen_owner: "www-data"
    listen_group: "www-data"
    listen_mode: "0660"
    pm: "dynamic"
  'aman':
    listen: "/var/run/php/php7.0-fpm.aman.sock"
    listen_owner: "www-data"
    listen_group: "www-data"
    listen_mode: "0660"
    pm: "dynamic"
    user: "aman"
    group: "aman"	
php::composer::auto_update: true
php::package_prefix: "php7.0-"
php::manage_repos:

php::packages::ensure: present
php::packages::names:
  - "php7.0-mysql"
  - "php7.0-mcrypt"
  - "php7.0-cli" 
php::packages::names_to_prefix:
  - "php7.0-"

nginx::nginx_vhosts:
  'www.example.com':
    www_root: "/opt/wordpress"
    try_files: 
      - "$uri $uri/ /index.html"  
  'www.example1.com':
    www_root: "/opt/wordpressnew"
    try_files:
      - "$uri $uri/ /index.html"

nginx::nginx_locations:
  'php':
    ensure: present
    www_root: "/opt/wordpress"
    location: '~ \.php$'
    vhost: 'www.example.com'
    try_files: 
      - "$uri =404"
    fastcgi: "unix:/var/run/php/php7.0-fpm.sock"
    fastcgi_param: 
      "SCRIPT_FILENAME": "$document_root$fastcgi_script_name"
    option: "index.php"
  'phptest':
    ensure: present
    www_root: "/opt/wordpressnew"
    location: '~ \.php$'
    vhost: 'www.example1.com'
    try_files:
      - "$uri =404"
    fastcgi: "unix:/var/run/php/php7.0-fpm.aman.sock" 
    fastcgi_param:
      "SCRIPT_FILENAME": "$document_root$fastcgi_script_name"
    option: "index.php"
###################################################################
