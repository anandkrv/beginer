class sftpjail::user(
               $homedir = '',
               $group_name = '',
               $user_pass = []
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
                              file{"/sftp":
                                                ensure => directory,
                                                recurse => true
                                    }


                              group {"$group_name":
                                                ensure => present
                                    }

#notify {"$group_name":}

               define createUser (
                                   $group_name ="$group_name",
                                   $homedir = "$homedir"
                                 ){
                                  
                                 $user_name= inline_template("<%= @name.split(':')[0] %>")
                                 $password= inline_template("<%= @name.split(':')[1] %>")

#notify {"value :$umeser_pass":}
#notify {"pass :$password":}


                                   user {"$user_name":
                                             # password => generate('/bin/sh', '-c', "mkpasswd -m sha-512 ${u_pass} | tr -d '\n'"),
                                               groups => "$group_name",
                                               home => "$homedir"
                                        }


                                  
                                   exec{"$password":
                                               command => "bash -c  'echo -e \"$password\n$password\" | passwd $user_name'",
                                               require => User[$user_name]
                                       }

                                 

                   
                                 file{"/sftp/$user_name":
                                                path => "/sftp/$user_name",
                                                ensure => directory,
                                                recurse => true
                                     }


                                 file{"/sftp/$user_name$homedir":
                                                ensure => directory,
                                                group => "$group_name",
                                                owner => $user_name,
                                      } 

                               } 
                                   createUser{ $user_pass:

                                            homedir => "$homedir",
                                            group_name => "$group_name"
              
 }
                  }
