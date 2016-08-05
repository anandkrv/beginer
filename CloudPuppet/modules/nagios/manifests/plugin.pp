# == Define: nrpe::plugin
#
# Deploy a nagios plugin to deploy to the standard nagios plugins directory for
# the current kernel
#
# === Parameters
#
# [*source*]  location where the plugin should be deployed from
# [*command*] name of the command which the plugin should be deployed as
# [*path]     where the plugin should be deployed to
#
# === Authors
#
# Christopher Johnson - cjohn@ceh.ac.uk
#
define nagios::plugin (
  $source,
  $command = $name,
  $path    = $::nagios::plugins_path,
) {
  if ! defined(Class['::nagios']) {
    fail('You must include the nagios base class before nagios::plugin')
  }

  file { "${path}/${command}" :
    mode   => '755',
    source => $source,
  }
}
