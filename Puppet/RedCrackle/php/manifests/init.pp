# == Class: php
#
# Full description of class php here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'php':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class php(
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

	$req_packages = [ "gcc", "make", "freetype2*", "curl", "libfcgi-dev", "libfcgi0ldbl", "libjpeg62-dbg", "libmcrypt-dev", "libssl-dev", "libjpeg-dev", "libfreetype6-dev", "libxpm-dev", "libxml2-dev", "libpcre3-dev", "libbz2-dev", "libcurl4-openssl-dev", "libpng12-dev", "libmysqlclient-dev", "libt1-dev", "libgd2-xpm-dev", "libgmp-dev", "libsasl2-dev", "libmhash-dev", "unixodbc-dev", "freetds-dev", "libpspell-dev", "libsnmp-dev", "libtidy-dev", "libxslt1-dev", "libdb5.3-dev" ]

        package {$req_packages:
        ensure => "installed",
	before => Exec['download_php'],
        }

       exec { "download_php":
       command   => "wget -O /var/tmp/php-${php_version}.tar.bz2 http://php.net/distributions/php-${php_version}.tar.bz2;mkdir -p /opt/build;tar jxf /var/tmp/php-${php_version}.tar.bz2 -C /opt/build;",
        creates => "/opt/build/php-${php_version}/",
       logoutput => true,
       timeout   => 1800
        }

        file{"/usr/include/freetype2/freetype":
                require => Exec['download_php'],
                ensure => ['directory','present'],
                mode => 0755
        }
        file{"/usr/include/freetype2/freetype/freetype.h":
                require => File['/usr/include/freetype2/freetype'],
                ensure => link,
                target => "/usr/include/freetype2/freetype.h"
        }

	exec{ "loc":
		require => File['/usr/include/freetype2/freetype/freetype.h'],
		environment => ["LANG=en_US.UTF-8","LC_CTYPE=en_US.UTF-8","LC_NUMERIC=en_US.UTF-8","LC_TIME=en_US.UTF-8","LC_COLLATE=en_US.UTF-8","LC_MONETARY=en_US.UTF-8","LC_MESSAGES=en_US.UTF-8","LC_PAPER=en_US.UTF-8","LC_NAME=en_US.UTF-8","LC_ADDRESS=en_US.UTF-8","LC_TELEPHONE=en_US.UTF-8","LC_MEASUREMENT=en_US.UTF-8","LC_IDENTIFICATION=en_US.UTF-8","LC_ALL=en_US.UTF-8"],
		command => "locale"
	}

       exec { "install_php":
        require => Exec['loc'],
        cwd     => "/opt/build/php-${php_version}",
	environment => ["LANG=en_US.UTF-8","LANGUAGE=en_US.UTF-8","LC_CTYPE=en_US.UTF-8","LC_NUMERIC=en_US.UTF-8","LC_TIME=en_US.UTF-8","LC_COLLATE=en_US.UTF-8","LC_MONETARY=en_US.UTF-8","LC_MESSAGES=en_US.UTF-8","LC_PAPER=en_US.UTF-8","LC_NAME=en_US.UTF-8","LC_ADDRESS=en_US.UTF-8","LC_TELEPHONE=en_US.UTF-8","LC_MEASUREMENT=en_US.UTF-8","LC_IDENTIFICATION=en_US.UTF-8","LC_ALL=en_US.UTF-8"],
        command  => "bash configure --enable-fpm --with-mcrypt --enable-mbstring --with-openssl --with-mysql --with-mysql-sock --with-gd --with-jpeg-dir=/usr/lib --enable-gd-native-ttf --with-pdo-mysql --with-libxml-dir=/usr/lib --with-mysqli=/usr/bin/mysql_config --with-curl --enable-zip  --enable-sockets --with-zlib --enable-exif --enable-ftp --with-iconv --with-gettext --enable-gd-native-ttf --with-t1lib=/usr --with-freetype-dir=/usr --prefix=/opt/PHP-${php_version} --with-config-file-path=/opt/PHP-${php_version}/etc --with-fpm-user=www-data --with-fpm-group=www-data;make;make test;make install",
       timeout   => 2400,
       creates => "/opt/PHP-${php_version}",
       logoutput => true
     }

	file { 'php_ini':
		path => "/opt/PHP-${php_version}/etc/php.ini",
		require => Exec['install_php'],
		content => template('php/php.ini.erb'),
		#source => '/etc/puppet/modules/php/templates/php.ini.erb',
		owner => 'root',
		group => 'root',
		mode => '644',
	} 

	file { 'php_fpm':
		path => "/opt/PHP-${php_version}/etc/php-fpm.conf",
                require => File['php_ini'],
		#content => template('php/php-fpm.conf.erb'),
                source => "/opt/PHP-${php_version}/etc/php-fpm.conf.default",
                owner => 'root',
                group => 'root',
                mode => '644',
        }

	exec {"install_m4":
		require => File['php_fpm'],
		cwd => "/opt/build",
		command => "wget -O m4-1.4.9.tar.gz http://ftp.gnu.org/gnu/m4/m4-1.4.9.tar.gz;tar -zvxf m4-1.4.9.tar.gz;cd m4-1.4.9;bash configure;make;make install",
		creates => "/opt/build/m4-1.4.9/"
	}

	exec {"install_autoconf":
		require => Exec['install_m4'],
		cwd=> "/opt/build",
		command => "curl http://ftp.gnu.org/gnu/autoconf/autoconf-latest.tar.gz > autoconf.tar.gz;tar -xvzf autoconf.tar.gz;cd autoconf-2.69;bash configure;sudo make && sudo make install;export PHP_AUTOCONF=/usr/local/bin/autoconf",
		creates => "/opt/build/autoconf-2.69/"
	}
	
	exec { "install_apc":
	    require => Exec['install_autoconf'],
	    cwd => "/opt/PHP-${php_version}/bin",
	    #command => "ls",
	    command => "bash pecl install apc",
	    unless => "find / -iname apc.so | egrep '.*'"
	}

	exec { "install_memcache":
            require => Exec['install_apc'],
            cwd => "/opt/PHP-${php_version}/bin",
            #command => "ls",
            command => "bash pecl install memcache",
            unless => "find / -iname memcache.so | egrep '.*'"
        }

	file { "/etc/init.d/php-fpm":
		require => Exec['install_memcache'],
		#content => template('php/upstart_fpm.conf.erb'),
		source => "/opt/build/php-${php_version}/sapi/fpm/init.d.php-fpm",
		owner => 'root',
                group => 'root',
                mode => '755',
	}
	
	service { "php-fpm":
		require => File['/etc/init.d/php-fpm'],
		ensure => running,
		enable => true,
		hasstatus => false,
		pattern   => 'php-fpm',
	}

	exec { "update_path":
		require => Service['php-fpm'],
		command => "update-alternatives --install /usr/bin/php php /opt/PHP-${php_version}/bin/php 100;update-alternatives --install /usr/bin/pear pear /opt/PHP-${php_version}/bin/pear 100;update-alternatives --install /usr/bin/peardev peardev /opt/PHP-${php_version}/bin/peardev 100;update-alternatives --install /usr/bin/pecl pecl /opt/PHP-${php_version}/bin/pecl 100",
	}
}
