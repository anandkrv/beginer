# = Class: nfs::client
#
# This is the nfs::client
#
class nfs::client {

  require nfs

  package { $nfs::package:
    ensure  => $nfs::manage_package,
    noop    => $nfs::noops,
  }

}
