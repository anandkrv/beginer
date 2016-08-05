# == Class: deploydrupalapp
#
# Full description of class deploydrupalapp here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { deploydrupalapp:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class deploydrupalapp(
$github_url = 'https://github.com/OpsTree/DrupalSampleApp.git',
$git_branch_name = 'master',
$db_host_ip = 'localhost',
$db_username = 'root',
$db_password = 'password',
$db_name = 'drupaldb',
$drupal_ip_addresses = [],
$drupal_deploy_path = '/usr/share/nginx/www',
) {
  Exec {
                path => [
                        '/usr/local/bin',
                        '/opt/local/bin',
                        '/usr/bin',
                        '/usr/sbin',
                        '/bin',
                        '/sbin'],
                        logoutput => true
  }

#       require drupalserver

  file{"$drupal_deploy_path":
#    require => Class['nginx'],
    ensure => ['directory','present'],
    mode => 0755
  }   
  git::repo{'repo_name':
    require => File["$drupal_deploy_path"],
    path   => "$drupal_deploy_path",
    source => "$github_url",
    branch => "$git_branch_name",
    update => true,
    before => Exec['ownership_drupal_app'],
  }
  exec{ 'ownership_drupal_app':
    command => "chown -R www-data:www-data $drupal_deploy_path;rm -rf /etc/nginx/conf.d/default.conf",
  }
  
  file { 'check_mysqldb_script':
    path => "/tmp/check_mysqldb_script.sh",
    require => Exec['ownership_drupal_app'],
    content => template('deploydrupalapp/check_mysqldb.sh.erb'),
    owner => 'root',
    group => 'root',
    mode => '755',
  }  

  exec{ 'configure_site':
    require => File['check_mysqldb_script'],
    cwd => "$drupal_deploy_path",
    command => "drush site-install -y --account-pass=password --db-url=mysql://$db_username:$db_password@$db_host_ip:3306/$db_name",
    unless => "bash /tmp/check_mysqldb_script.sh $db_host_ip $db_username $db_password $db_name",
    returns => [ "0", "1", ],
  }

  file { 'settings_php':
    path => "$drupal_deploy_path/sites/default/settings.php",
    require => Exec['configure_site'],
    content => template('deploydrupalapp/settings.php.erb'),
    owner => 'root',
    group => 'root',
    mode => '444',
  }

  exec{ 'enable_memcache':
    require => File['settings_php'],
    cwd => "$drupal_deploy_path",
    command => "drush en memcache memcache_admin -y",
  }

  exec{'restart_nginx':
    require => Exec['enable_memcache'],
    command => "/etc/init.d/nginx restart"
  }
}
