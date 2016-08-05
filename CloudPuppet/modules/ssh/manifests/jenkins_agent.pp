class ssh::jenkins_agent {
 
        file {"/srv/tomcat/.ssh/authorized_keys":
                source => "puppet:///modules/ssh/id_rsa.pub",
                owner  => "tomcat",
                group  => "tomcat",
                mode  => "600",
                require => File["/srv/tomcat/.ssh"]
        }

        file {"/srv/tomcat/.ssh/":
                ensure => directory,
                owner => "tomcat",
                group => "tomcat",
                mode  => "700"
        }
}

