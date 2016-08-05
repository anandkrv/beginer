class gluster::peer(
$peers = []
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

  define myResource {
    exec { "gluster peer probe $name":
      unless  => "/bin/egrep '^hostname.+=${name}$' /var/lib/glusterd/peers/*"
    }
  }
  myResource { $peers: }
}
