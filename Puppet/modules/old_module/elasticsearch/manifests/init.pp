class elasticsearch ($version = "0.90.12",){
                        '/usr/local/bin',
                        '/opt/local/bin',
                        '/usr/bin',
                        '/usr/sbin',
                        '/bin',
                        '/sbin'],
                        logoutput => true,
        }
       exec { "install_elasticsearch":
        cwd      =>  "/opt",
       command   => "wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-$version.deb;dpkg -i elasticsearch-$version.deb",
       logoutput => true,
       timeout   => 1800,
        }

        service { "elasticsearch":
            enable  => true,
            ensure  => running,
            require => Exec["install_elasticsearch"],
       }
}

