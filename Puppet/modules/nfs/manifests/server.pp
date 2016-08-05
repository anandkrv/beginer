# = Class: nfs::server
#
# This is the nfs::server class
#
class nfs::server {

  require nfs

  if $nfs::package_server != '' {
    package { $nfs::package_server:
      ensure  => $nfs::manage_package,
      noop    => $nfs::noops,
    }
  }

  service { 'nfs':
    ensure     => $nfs::manage_service_ensure,
    name       => $nfs::service,
    enable     => $nfs::manage_service_enable,
    hasstatus  => $nfs::service_status,
    pattern    => $nfs::process,
    require    => Package[$nfs::package],
    noop       => $nfs::noops,
  }

  file { 'nfs.conf':
    ensure  => $nfs::manage_file,
    path    => $nfs::config_file,
    mode    => $nfs::config_file_mode,
    owner   => $nfs::config_file_owner,
    group   => $nfs::config_file_group,
    require => Package[$nfs::package],
    notify  => $nfs::manage_service_autorestart,
    source  => $nfs::manage_file_source,
    content => $nfs::manage_file_content,
    replace => $nfs::manage_file_replace,
    audit   => $nfs::manage_audit,
    noop    => $nfs::noops,
  }

  # The whole nfs configuration directory can be recursively overriden
  if $nfs::source_dir
  and $nfs::config_dir != '' {
    file { 'nfs.dir':
      ensure  => directory,
      path    => $nfs::config_dir,
      require => Package[$nfs::package],
      notify  => $nfs::manage_service_autorestart,
      source  => $nfs::source_dir,
      recurse => true,
      purge   => $nfs::bool_source_dir_purge,
      force   => $nfs::bool_source_dir_purge,
      replace => $nfs::manage_file_replace,
      audit   => $nfs::manage_audit,
      noop    => $nfs::noops,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $nfs::bool_monitor == true {
    if $nfs::port != '' {
      monitor::port { "nfs_${nfs::protocol}_${nfs::port}":
        protocol => $nfs::protocol,
        port     => $nfs::port,
        target   => $nfs::monitor_target,
        tool     => $nfs::monitor_tool,
        enable   => $nfs::manage_monitor,
        noop     => $nfs::noops,
      }
    }
    if $nfs::service != '' {
      monitor::process { 'nfs_process':
        process  => $nfs::process,
        service  => $nfs::service,
        pidfile  => $nfs::pid_file,
        user     => $nfs::process_user,
        argument => $nfs::process_args,
        tool     => $nfs::monitor_tool,
        enable   => $nfs::manage_monitor,
        noop     => $nfs::noops,
      }
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $nfs::bool_firewall == true and $nfs::port != '' {
    firewall { "nfs_${nfs::protocol}_${nfs::port}":
      source      => $nfs::firewall_src,
      destination => $nfs::firewall_dst,
      protocol    => $nfs::protocol,
      port        => $nfs::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $nfs::firewall_tool,
      enable      => $nfs::manage_firewall,
      noop        => $nfs::noops,
    }
  }


}
