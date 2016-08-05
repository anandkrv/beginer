# == Define: nagios::nrpe
#
# Define an nrpe service which can be monitored by a remote nagios server.
#
# === Parameters
#
# [*command*] The command to run
# [*service_description*] A description of this nrpe service
# [*notifications_enabled*] If nagios should notify when this command fails
# [*notification_period*] The notification period of this nrpe service
# [*host_name*] The host name which this nagios service can be contacted on.
# [*command_name*] The name of the command
# [*use*] A nagios service template to use
#
# === Requires
# - nagios::client
#
# === Authors
#
# Christopher Johnson - cjohn@ceh.ac.uk
#
define nagios::nrpe (
  $command,
  $service_description,
  $notifications_enabled = undef,
  $notification_period   = $nagios::check::default_notification_period,
  $host_name             = $fqdn,
  $command_name          = $name,
  $use                   = 'generic-service'
) {
  if ! defined(Class['::nagios::client']) {
    fail('You must include the nagios::client class before defining a nagios::nrpe')
  }

  concat::fragment { "command ${name} ${nagios::client::nrpe_config}":
    target  => $::nagios::client::nrpe_config,
    content => "command[${name}]=${command}\n",
  }

  @@nagios_service { "${command_name}_${fqdn}" :
    check_command         => "check_nrpe_1arg!${command_name}",
    use                   => $use,
    host_name             => $host_name,
    notification_period   => $notification_period,
    service_description   => $service_description,
    notifications_enabled => $notifications_enabled,
  }
}
