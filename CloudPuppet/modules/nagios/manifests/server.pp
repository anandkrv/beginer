# == Class: nagios::server
#
# This class downloads and installs the nagios and sets up the nagios configuration files
# to configure.
#
# === Parameters
#
# [*version*] The version of nagios to install
# [*nrpe_version*] The version of nrpe-plugin to install
# [*user*] The user which the nagios server should run as
# [*group*] The group which the server should run as
# [*plugins_version*] The version of the plugins to install
# [*pnp4nagios_version*] The version of the pnp4nagios to install
# [*process_performance_data*] If performance data should be processed
# [*host_perfdata_file_processing_interval*] Interval in which the performance data for hosts 
#   should be bulk processed
# [*service_perfdata_file_processing_interval*] Interval in which the performance data 
#   for servicesshould be bulk processed
# [*users_file*] The location of the users file which can be managed with nagios::user
# [*config_files*] The config files which are to be managed by puppet (sets these to mode 644)
#
# === Authors
#
# Christopher Johnson - cjohn@ceh.ac.uk
#
class nagios::server(
  $version                                   = installed,
  $nrpe_version                              = installed,
  $user                                      = $::nagios::user,
  $group                                     = $::nagios::group,
  $plugins_version                           = installed,
  $pnp4nagios_version                        = installed,
  $process_performance_data                  = 1,
  $host_perfdata_file_processing_interval    = 15,
  $service_perfdata_file_processing_interval = 15,
  $enable_embedded_perl                      = 0,
  $use_embedded_perl_implicitly              = 0,
  $config_dirs = [
    '/etc/nagios-plugins/config',
    '/etc/nagios'
  ],
  $users_file      = '/etc/nagios3/htpasswd.users',
  $config_files = [
    '/etc/nagios/nagios_command.cfg',
    '/etc/nagios/nagios_contact.cfg',
    '/etc/nagios/nagios_contactgroup.cfg',
    '/etc/nagios/nagios_host.cfg',
    '/etc/nagios/nagios_hostdependency.cfg',
    '/etc/nagios/nagios_hostescalation.cfg',
    '/etc/nagios/nagios_hostextinfo.cfg',
    '/etc/nagios/nagios_hostgroup.cfg',
    '/etc/nagios/nagios_service.cfg',
    '/etc/nagios/nagios_servicedependency.cfg',
    '/etc/nagios/nagios_serviceescalation.cfg',
    '/etc/nagios/nagios_serviceextinfo.cfg',
    '/etc/nagios/nagios_servicegroup.cfg',
    '/etc/nagios/nagios_timeperiod.cfg'
  ]
) {
  if ! defined(Class['::nagios']) {
    fail('You must include the nagios base class before nagios::server')
  }

  # Ensure that all packages are installed before starting nagios
  Package {
    before => [ 
      Service['nagios3'],
      File[$::nagios::plugins_path]
    ],
  }

  package { 'nagios3' :
    ensure => $version,
  }

  package { 'nagios-nrpe-plugin' :
    ensure => $nrpe_version,
  }

  package { 'nagios-plugins' :
    ensure => $plugins_version,
  }

  package { 'pnp4nagios' :
    ensure => $pnp4nagios_version,
  }

  file { '/etc/nagios3/nagios.cfg' :
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    content => template('nagios/nagios.cfg.erb'),
    notify  => Exec['nagios3-verify'],
    require => Package['nagios3'],
  }
  
  file { '/etc/nagios' :
    ensure  => directory,
    recurse => true,
    mode    => 0644,
    purge   => true,
    before  => Service['nagios3'],
  }
  
  # Set all of the config files to the correct mode
  file { $config_files :
    mode    => 0644,
    ensure  => present,
    before  => Service['nagios3'],
  }

  concat { $users_file :
    require => Package['nagios3'],
  }

  # Verify that the nagios configuration is in a good state before restarting
  exec { 'nagios3-verify' :
    path        => '/usr/sbin',
    command     => 'nagios3 -v /etc/nagios3/nagios.cfg',
    refreshonly => true,
    notify      => Service['nagios3'],
  }

  service { 'nagios3' :
    ensure      => running,
    hasstatus   => true,
    hasrestart  => true,
  }
  
  # Gather the local resources
  Package['nagios3'] -> Nagios_command <||>           ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_contact <||>           ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_contactgroup <||>      ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_host <||>              ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_hostdependency <||>    ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_hostescalation <||>    ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_hostextinfo <||>       ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_hostgroup <||>         ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_service <||>           ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_servicedependency <||> ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_serviceescalation <||> ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_serviceextinfo <||>    ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_servicegroup <||>      ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_timeperiod <||>        ~> Exec['nagios3-verify']

  # Gather the exported nagios resources 
  Package['nagios3'] -> Nagios_command <<||>>           ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_contact <<||>>           ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_contactgroup <<||>>      ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_host <<||>>              ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_hostdependency <<||>>    ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_hostescalation <<||>>    ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_hostextinfo <<||>>       ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_hostgroup <<||>>         ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_service <<||>>           ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_servicedependency <<||>> ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_serviceescalation <<||>> ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_serviceextinfo <<||>>    ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_servicegroup <<||>>      ~> Exec['nagios3-verify']
  Package['nagios3'] -> Nagios_timeperiod <<||>>        ~> Exec['nagios3-verify']

  # Notify the nrpe service if the user or group change
  Package['nagios3'] -> User[$user]   ~> Service['nagios3']
  Package['nagios3'] -> Group[$group] ~> Service['nagios3']
}
