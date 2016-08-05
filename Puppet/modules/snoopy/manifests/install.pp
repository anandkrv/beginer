# == Class: snoopy::install
#
# Base class of snoopy module which installs snoopy, called from init
#
# === Parameters
#
# === Example
#
#   class {'snoopy::install':}
#
class snoopy::install(){
	# Ensure wget package is installed so that we can get snoopy install script
	package {'wget':}

	# Run wget command to get snoopy install script and give excutable permissions to it
	exec { 'get_snoopy_script':
		cwd => "/tmp",
		command => '/usr/bin/wget https://github.com/a2o/snoopy/raw/install/doc/install/bin/snoopy-install.sh;chmod 755 /tmp/snoopy-install.sh',
		creates => '/tmp/snoopy-install.sh',
		require => Package['wget'],
	}

	# Execute snoopy install script to install latest stable version of snoopy
	exec {'execute_install_script':
		cwd => '/tmp',
		command => '/tmp/snoopy-install.sh stable',
		creates => '/etc/snoopy.ini',
		require => Exec['get_snoopy_script'],
	}
}
