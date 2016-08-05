class ssh{

	package {"openssh-server":
		ensure => "latest",
	}

	file {'/etc/ssh/alok.conf':
		require => Package['openssh-server'],
		content => template('ssh/alok.conf'),
		notify => Service["ssh"],
	}

	service { 'ssh':
		ensure => 'running',
		enable => 'true',
		require => Package["openssh-server"],

		status => "/etc/init.d/ssh status|grep running",
	}
}


