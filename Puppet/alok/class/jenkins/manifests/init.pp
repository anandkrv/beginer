class jenkins{
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
       exec { 'apt-update': 
       command => '/usr/bin/apt-get update'  
        }

       package { "jenkins":
       require => Exec['apt-update'], 
        ensure      => 'installed',
    } 
       
        notify { "jenkins is installed":
        }

         service { "jenkins":
         ensure=>'running',
        }
}


