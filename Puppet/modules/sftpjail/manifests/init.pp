# == Class: sftpjail
# Author Name <opstree.com>
#
# === Copyright
#
# Copyright 2015 opstree.
#
class sftpjail( 
$homedir      = $sftpjail::params::homedir,
$group_name   = $sftpjail::params::group_name,
$user_pass    = $sftpjail::params::user_pass
)inherits sftpjail::params{

  class { 'sftpjail::client': 
    group_name => "$group_name",
    user_pass => $user_pass,
    homedir => "$homedir"
  } 

}
