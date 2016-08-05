class php::drush(
$php_version = "$php::params::php_version"
) inherits php::params {
	Exec {
                path => [
                        '/usr/local/bin',
                        '/opt/local/bin',
                        '/usr/bin',
                        '/usr/sbin',
                        '/bin',
                        '/sbin'],
                        logoutput => true
        }
	exec {"add_drush_channel":
		require => Class['php'],
                cwd => "/opt/PHP-${php_version}/bin",
                command => "/opt/PHP-${php_version}/bin/pear channel-discover pear.drush.org",
		unless => "find / -iname drush | egrep '.*'"
        }
	exec { "install_drush":
		require => Exec['add_drush_channel'],
		cwd => "/opt/PHP-${php_version}/bin",
		command => "/opt/PHP-${php_version}/bin/pear install drush/drush && mv /opt/PHP-${php_version}/bin/drush /usr/bin && mv /opt/PHP-${php_version}/bin/drush.bat /usr/bin",
		creates => '/usr/bin/drush'
	}
}
