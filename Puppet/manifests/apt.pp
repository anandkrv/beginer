Use this command to install apt
puppet module install puppetlabs-apt

# Install apt
class { 'apt':
  always_apt_update    => false,
  apt_update_frequency => undef,
  disable_keys         => undef,
  proxy_host           => false,
  proxy_port           => '8080',
  purge_sources_list   => false,
  purge_sources_list_d => false,
  purge_preferences_d  => false,
  update_timeout       => undef,
  fancy_progress       => undef
}

#Sets the default Apt release
 class { 'apt::release':
  release_id => 'precise',
}

#
