class logs($version = "1.4.2",){
        Exec {
                path => [
                        '/usr/local/bin',
                        '/opt/local/bin',
                        '/usr/bin',
                        '/usr/sbin',
                        '/bin',
                        '/sbin'],$version
                        logoutput => true,
        }
       exec { "install_logstash":
        cwd      =>  "/opt"
       command   => "wget https://download.elasticsearch.org/logstash/logstash/logstash-$version.tar.gz;tar zxvf logstash-$version.tar.gz;mv logstash-1.4.2 server",
       logoutput => true,
       timeout   => 1800,
        }

         file {"/etc/init/logstash_server.conf":
        ensure => ['directory', 'present'],
        source => "puppet:///modules/logs/file/logstash_server.conf",
        owner  => 'root',
        group  => 'root',
        mode   => '640',
}

