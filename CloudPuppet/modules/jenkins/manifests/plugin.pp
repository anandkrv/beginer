#
# config_filename = undef
#   Name of the config file for this plugin.
#
# config_content = undef
#   Content of the config file for this plugin. It is up to the caller to
#   create this content from a template or any other mean.
#
# update_url = undef
#
# source = undef
#   Direct URL from which to download plugin without modification.  This is
#   particularly useful for development and testing of plugins which may not be
#   hosted in the typical Jenkins' plugin directory structure.  E.g.,
#
#   https://example.org/myplugin.hpi
#
define jenkins::plugin(
  $version         = 0,
  $manage_config   = false,
  $config_filename = undef,
  $config_content  = undef,
  $update_url      = undef,
  $enabled         = true,
  $source          = undef,
  $digest_string   = '',
  $digest_type     = 'sha1',
  # deprecated
  $plugin_dir      = undef,
  $username        = undef,
  $group           = undef,
  $create_user     = true,
) {
  include ::jenkins
  include jenkins::cli
  include jenkins::cli::reload
  
  validate_bool($manage_config)
  validate_bool($enabled)
  # TODO: validate_str($update_url)
  validate_string($source)
  validate_string($digest_string)
  validate_string($digest_type)

  if $plugin_dir {
    warning('jenkins::plugin::plugin_dir is deprecated and has no effect -- see jenkins::localstatedir')
  }
  if $username {
    warning('jenkins::plugin::username is deprecated and has no effect -- see jenkins::user')
  }
  if $group {
    warning('jenkins::plugin::group is deprecated and has no effect -- see jenkins::group')
  }
  if $create_user {
    warning('jenkins::plugin::create_user is deprecated and has no effect')
  }

  if ($version != 0) {
    $plugins_host = $update_url ? {
      undef   => $::jenkins::default_plugins_host,
      default => $update_url,
    }
    $base_url = "${plugins_host}/download/plugins/${name}/${version}/"
    $search   = "${name} ${version}(,|$)"
  }
  else {
    $plugins_host = $update_url ? {
      undef   => $::jenkins::default_plugins_host,
      default => $update_url,
    }
    $base_url = "${plugins_host}/latest/"
    $search   = "${name} "
  }

  # if $source is specified, it overrides any other URL construction
  $download_url = $source ? {
    undef   => "${base_url}${name}.hpi",
    default => $source,
  }

  $plugin_ext = regsubst($download_url, '^.*\.(hpi|jpi)$', '\1')
  # $plugin     = "${name}.${plugin_ext}"
  $plugin     = "${name}"
  $plugin_extention = "${name}.${plugin_ext}"

  if (empty(grep([ $::jenkins_plugins ], $search))) {
    if ($jenkins::proxy_host) {
      $proxy_server = "${jenkins::proxy_host}:${jenkins::proxy_port}"
    } else {
      $proxy_server = undef
    }

    $enabled_ensure = $enabled ? {
      false   => present,
      default => absent,
    }

    # Allow plugins that are already installed to be enabled/disabled.
   file { "${::jenkins::plugin_dir}/${plugin}.disabled":
      ensure  => $enabled_ensure,
      owner   => $::jenkins::user,
      group   => $::jenkins::group,
      mode    => '0644',
      require => Exec["${plugin_extention}-plugin-install"],
      notify  => Service['jenkins'],
    }

   file { "${::jenkins::plugin_dir}/${plugin}.pinned":
      owner   => $::jenkins::user,
      group   => $::jenkins::group,
      require => Exec["${plugin_extention}-plugin-install"],
   }

    if $digest_string == '' {
      $checksum = false
    } else {
      $checksum = true
    }

    $jar = "${jenkins::libdir}/jenkins-cli.jar"
    $extract_jar = "jar -xf ${jenkins::libdir}/jenkins.war WEB-INF/jenkins-cli.jar"
    $move_jar = "mv WEB-INF/jenkins-cli.jar ${jar}"
    $remove_dir = 'rm -rf WEB-INF'
    $cli_tries          = $::jenkins::cli_tries
    $cli_try_sleep   = $::jenkins::cli_try_sleep
    $jenkins_cli        = $jenkins::cli::cmd

    exec { "jenkins-cli-${plugin}":
      command => "${extract_jar} && ${move_jar} && ${remove_dir} && service jenkins restart && sleep 10",
      path    => ['/bin', '/usr/bin', '/sbin', '/usr/sbin/'],
      cwd     => '/tmp',
      unless  => "test -e $jar",
      logoutput   => true,
      notify      => Service['jenkins'],
    }

    exec { "${plugin_extention}-plugin-install":
      command     => "$jenkins_cli install-plugin ${plugin}",
      logoutput   => true,
      path        => '/bin:/usr/bin:/sbin:/usr/sbin',
      cwd         => "$::jenkins::localstatedir",
      user        => "$::jenkins::user",
      unless      => "test -e  $::jenkins::plugin_dir/${plugin}*",
      provider    => shell,
      tries       => $::jenkins::cli_tries,
      try_sleep   => $::jenkins::cli_try_sleep,
      notify      => Service['jenkins'],
      require     => [
                     File[$::jenkins::plugin_dir],
                     Exec["jenkins-cli-${plugin}"],
                   ],
    }
  }

  if $manage_config {
    if $config_filename == undef or $config_content == undef {
      fail 'To deploy config file for plugin, you need to specify both $config_filename and $config_content'
    }

    file {"${::jenkins::localstatedir}/${config_filename}":
      ensure  => present,
      content => $config_content,
      owner   => $::jenkins::user,
      group   => $::jenkins::group,
      mode    => '0644',
      notify  => Service['jenkins']
    }
  }
}
