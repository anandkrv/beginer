class selinux::manage ($selinuxState="Permissive") {

	case $selinuxState {
	        'Permissive': {
        	        $seStatus=0
                	notify { "setting status for $selinuxState": }
	        }
        	'Enforce': {
                	notify { "setting status for $selinuxState": }
	                $seStatus=1
        	}
	}

	exec { 'selinux-enforce' :
		#If state is not alread set, setting it
		command => "/usr/sbin/setenforce $seStatus",
		unless => "/usr/sbin/getenforce | grep $selinuxState 2>/dev/null",    
		logoutput => "true",
	}

	file { 'selinux-config':
		path => '/etc/selinux/config',
		ensure => file,
		content => template("selinux/selinux_config.erb"), 
	}	

}

