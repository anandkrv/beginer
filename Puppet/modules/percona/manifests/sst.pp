class percona::sst (
$sst_user = "sst",
$sst_password = "secret"
) {
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

          exec { "create_sst_user":
            command   => "mysql -e \"GRANT RELOAD, LOCK TABLES, REPLICATION CLIENT ON *.* TO '$sst_user'@'localhost' IDENTIFIED BY '$sst_password';\"",
            require => Class['percona'],
            logoutput => true
        }

}
