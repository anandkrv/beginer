class ssh::jenkins {

        file {"/var/lib/jenkins/.ssh/id_rsa":
                source => "puppet:///modules/ssh/id_rsa",
                owner  => "jenkins",
                group  => "jenkins",
                mode  => "600",
		require => File["/var/lib/jenkins/.ssh"]
        }	
        file {"/var/lib/jenkins/.ssh/config":
                source => "puppet:///modules/ssh/config",
                owner  => "jenkins",
                group  => "jenkins",
                mode  => "600",
		require => File["/var/lib/jenkins/.ssh"]
        }

        file {"/var/lib/jenkins/.ssh":
	        ensure => directory,
		owner => "jenkins",
                group => "jenkins",
                mode  => "700"
        }       
	
        file {"/var/lib/jenkins/.m2/settings.xml":
                source => "puppet:///modules/ssh/settings.xml",
                owner  => "jenkins",
                group  => "jenkins",
                require => File["/var/lib/jenkins/.m2"]
        }

        file {"/var/lib/jenkins/.m2":
                ensure => directory,
                owner => "jenkins",
                group => "jenkins"
        }
	package { "firefox":
		ensure => present,
	}
}
