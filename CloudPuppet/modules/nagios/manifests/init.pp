# == Class: nagios
#
# Namespace for nagios module, it also defines the current platform specific
# defaults for file locations and names
#
# === Parameters
#
# [*user*] The user which the nrpe client and server should run as
# [*group*] The group which the nrpe client and server should run as
# [*manage_user*] If the user should be managed
# [*manage_group*] If the group should be managed
# [*manage_plugins_path*] If the plugins path should be managed
#
# === Authors
#
# Christopher Johnson - cjohn@ceh.ac.uk
#
class nagios (
  $user                = 'nagios',
  $group               = 'nagios',
  $manage_user         = true,
  $manage_group        = true,
  $manage_plugins_path = true
) {
  $nrpe_package = $::osfamily ? {
    Darwin  => 'nrpe',
    RedHat  => 'nrpe',
    default => 'nagios-nrpe-server'
  }

  $package_provider = $::osfamily ? {
    Darwin  => 'brew',
    default => undef
  }

  $nrpe_config = $::osfamily ? {
    Darwin  => '/usr/local/etc/nrpe.cfg',
    RedHat  => '/etc/nagios/nrpe.cfg',
    default => '/etc/nagios/nrpe_local.cfg'
  }

  $nrpe_service = $::osfamily ? {
    Darwin  => 'org.nrpe.agent',
    RedHat  => 'nrpe',
    default => 'nagios-nrpe-server'
  }

  $nrpe_plugins = $::osfamily ? {
    RedHat  => 'nagios-plugins-all',
    default => 'nagios-plugins',
  }

  $plugins_path = $::osfamily ? {
    Darwin  => '/usr/local/opt/nagios-plugins/sbin',
    RedHat  => '/usr/lib64/nagios/plugins',
    default => '/usr/lib/nagios/plugins'
  }

  if $manage_plugins_path {
    file { $plugins_path :
      ensure => directory,
    }
  }

  if $manage_user {
    user { $user :
      ensure => present,
    }
  }

  if $manage_group {
    group { $group :
      ensure => present,
    }
  }
}
