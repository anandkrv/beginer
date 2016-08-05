class gluster::create_vol(
  $vol_name = "",
  $create_options = ""
){
  
  Exec {
     path => [
        '/usr/local/bin',
        '/opt/local/bin',
        '/usr/bin',
        '/usr/sbin',
        '/bin',
        '/sbin'],
        logoutput => true,
  }

  exec { "gluster_create_volume":
    command => "gluster volume create $vol_name ${create_options}",
    creates => "/var/lib/glusterd/vols/$vol_name",
    require => Class['gluster'],
  }

  exec { "gluster volume start $vol_name":
    unless  => "gluster volume info $vol_name",
    require => Exec["gluster_create_volume"],
  }

}
