include zabbix::repo
class { 'zabbix::agent':
  pidFile              => '/var/run/zabbix/zabbix_agentd.pid',
  logFile              => '/var/log/zabbix/zabbix_agentd.log',
  enableRemoteCommands => '1',
  server               => '192.168.1.7',
  hostname             => 'vagrant-ubuntu-precise-64',
}
