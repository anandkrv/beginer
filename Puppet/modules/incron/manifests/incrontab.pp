define incron::incrontab(
	$user_name    = undef,
	$user_command = undef,
	$user_path    = undef,
	$user_mask    = undef,
	$user_allow   = undef,
	$user_deny    = undef,
){
	$domain = $title
	incron {$domain:
               		user    => $user_name,
               		command => $user_command,
			mask	=> $user_mask,
               		path    => $user_path
	}
	if $user_allow {
		incron_allowuser { $user_allow:
  			ensure => present,	
		}
	}
	if $user_deny {
		incron_denyuser { $user_deny:
			ensure => present,		
		}
	}
}
