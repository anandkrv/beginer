# == Class: sftpjail
# Author Name <opstree.com>
#
# === Copyright
#
# Copyright 2015 opstree.
#
class sftpjail( 
$homedir = '',
$group_name = "",
$user_pass = []
){

                   class { 'sftpjail::client': 
                                       group_name => "$group_name",
                                      user_pass => $user_pass,
                                       homedir => "$homedir"

                    } 


                  }
