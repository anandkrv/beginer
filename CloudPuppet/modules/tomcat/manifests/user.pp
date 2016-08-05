class tomcat::user {
  user {'tomcat':
    ensure 	=> present,
    uid    	=> $::tomcat::tomcat_uid,
    gid    	=> $::tomcat::tomcat_gid,
    managehome 	=> true,
    shell       => '/bin/bash',
    system 	=> true,
    home        => $::tomcat::instance_basedir,
  }
}
