class{ '::java': 
	distribution => "jdk",
}->
class { 'jenkins':
  install_java => false,
  version => '1.651.1-1.1',
  lts    => true,
  configure_firewall => false,
  executors => 3,
  plugin_hash => {
    'github' 			=> {}, 			
    'git'			=> {},		
    'junit'                     => {},
    'cucumber-reports'          => {},
    'parameterized-trigger' 	=> {},
    'conditional-buildstep' 	=> {},
    'htmlpublisher'             => {},
    'promoted-builds' 		=> {},	
    'maven-plugin'      	=> { manage_config => true,
                                     config_filename => 'hudson.tasks.Maven.xml',
                                     config_content => template('jenkins/config/plugin/hudson.tasks.Maven.xml.erb')},        
    'sonar'    			=> { manage_config => true,
 				     config_filename => 'hudson.plugins.sonar.SonarGlobalConfiguration.xml',
				     config_content => template('jenkins/config/plugin/hudson.plugins.sonar.SonarGlobalConfiguration.xml.erb') },
    'xvfb'     			=> { manage_config => true,
                                     config_filename => 'org.jenkinsci.plugins.xvfb.Xvfb.xml',
                                     config_content => template('jenkins/config/plugin/org.jenkinsci.plugins.xvfb.Xvfb.xml.erb')}
   },
 }->
class { "ssh::jenkins": }

class { 'display':
  display => 99, 
  width   => 1024,
  height  => 768,
}
class { 'zabbix::agent': 
  server => "172.31.0.30",
  serveractive => "172.31.0.30",
}

class { 'pip': }->
class { 'beaver': 
  status => enabled,
}
beaver::input::file{ "syslog":
  file => '/var/log/messages',
  type => 'syslog'
}
beaver::input::file{ "jenkins":
  file => '/var/log/jenkins',
  type => 'jenkins'
}
beaver::output::redis{ 'redisout':
  host =>'172.31.0.30',
  port => '6379',
}

