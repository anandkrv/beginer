Download setup.sh

wget https://raw.githubusercontent.com/OpsTree/AWSTraining/master/setup.sh

This script will do below setup
1. Git
2. Standalone Puppet
3. Instructions to setup nginx, tomcat or db

## puppet 
- create site.pp with node name for instance 
```
node "nginx" {
}
node "myapp" {
}
node "database"{
}
```
- put these snippet code lines of the compnents repectice node block 

## Setup Nginx Reverse Proxy for Production 
```
class { 'nginx': }
nginx::resource::upstream { 'tomcat_app':
  members => [
    '<IP_Tomcat_App>:8080',
  ],
}
nginx::resource::vhost { 'www.example.com':
  proxy => 'http://tomcat_app',
}
```
## Setup Tomcat Instance For app 
```
class { 'java':
  distribution => 'jre',
}
include tomcat
tomcat::instance {'myapp':
  ensure      => present,
  http_port   => '8080',
}
```
Service name of tomcat instance will be tomcat-myapp

To manage the service 
```
$ sudo service tomcat-myapp start|stop|restart|status
```
## Setup Mysql DataBase 
To install and create root password
```
class { '::mysql::server':
  root_password           => 'rootpassword',
}
```
To create db and user with some privileges
```
mysql::db { 'mydb':
  user     => 'myuser',
  password => 'mypass',
  host     => 'localhost',
  grant    => ['SELECT', 'UPDATE'],
}
```
Service name of the mysql will be mysql

To manage the service 
```
$ sudo service mysql start|restart|stop|status
```
