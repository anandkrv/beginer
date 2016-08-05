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
       exec { "install_jenkins":
       command   => "wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -;echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list",
       logoutput => true,
       timeout   => 1800,
        }

        exec { "jenkins":
       command   => "apt-get install jenkins",
       logoutput => true,
       timeout   => 1800,
        }
       
        notify { "jenkins is installed":
        }

         service { "jenkins":
         ensure=>'running',
        }
}


