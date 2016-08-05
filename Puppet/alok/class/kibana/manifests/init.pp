class kibana ($version = "3.1.0",) {
        Exec {
                path => [
                        '/usr/local/bin',
                        '/opt/local/bin',
                        '/usr/bin',
                        '/usr/sbin',
                        '/bin',
                        '/sbin'],
                        logoutput => true,
        }version
       exec { "install_kibana":
        cwd      =>  "/opt",
       command   => "wget https://download.elasticsearch.org/kibana/kibana/kibana-$version.tar.gz;tar xvfz kibana-$version.tar.gz",
       logoutput => true,
       timeout   => 1800,
        }
}
