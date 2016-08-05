# == Class: nagios::server
#
# This class downloads and installs the nagios and sets up the nagios configuration files
# to configure.
#
# === Parameters
#
# [*cryptpasswd*] The password for this user in htpasswd format
# [*username*] The username of this user defaults to $name
# [*users_file*] The location of the users file which users will be added to
#
# === Authors
#
# Christopher Johnson - cjohn@ceh.ac.uk
#
define nagios::user (
  $cryptpasswd,
  $username = $name,
  $users_file = $nagios::server::users_file
) {

  concat::fragment { "${name} ${users_file}" :
    target  => $users_file,
    content => "${username}:${cryptpasswd}",
    require => Package['nagios3'],
  }
}
