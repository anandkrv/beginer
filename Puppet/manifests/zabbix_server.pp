#Use this command to install zabbix
puppet module install ericsysmin-zabbix

#install zabbix repo server and frontend
include zabbix::repo
class { 'zabbix::server':
  dbHost                  => undef,
  dbName                  => undef,
  dbUser                  => undef,
  dbPassword              => alok,
  dbPort                  => undef,

}
include zabbix::frontend

#add this file in /etc/apache2/sites-available
vim  zabbix.conf
# Define /zabbix alias, this is the default
<IfModule mod_alias.c>
Alias /zabbix /usr/share/zabbix
</IfModule>


#service zabbix-server restart

#http://ip-address/zabbix
