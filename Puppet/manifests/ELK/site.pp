#################################################################################
# puppet module install --force ispavailability-file_concat --version 0.0.2
# puppet module install puppetlabs-apt --force --version 1.8.0
# puppet module install elasticsearch-elasticsearch
# puppet module install elasticsearch-logstash
# puppet module install echocat-kibana4
# puppet module install jfryman-nginx
# puppet module install puppetlabs-java
################################################################################

node "jenkins", "vagrant-centos64", "vagrant-ubuntu-trusty-64" {
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
 exec { 'elasticsearch-service':
                command => "bash -c 'service elasticsearch start'",
                logoutput => 'true',
                returns => ["0","129"],
		require => Class['elasticsearch']
        }	

	class { 'java':
  		distribution => 'jre',
	}
	
	
case $::osfamily {
	'RedHat':{
		class { "logstash":
                package_url => 'http://download.elastic.co/logstash/logstash/packages/centos/logstash-1.5.0-1.noarch.rpm',
		require => Class['java']
                }
		class { 'elasticsearch':
		package_url => 'https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.4.4.noarch.rpm',
		status => 'running',
		require => Class['java'],
		before => Class['kibana4']
		}

	}
	'Debian':{
		class { "logstash":
		package_url => 'http://download.elastic.co/logstash/logstash/packages/debian/logstash_1.5.0-1_all.deb',
		require => Class['java']
		}
		class { 'elasticsearch':
                package_url => 'https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.4.4.deb',
		status => 'running',
		require => Class['java'],
                before => Class['kibana4']
                }
	}
}
	
	package {"curl":
        	ensure => 'present',
		require => Class['elasticsearch']
	}

	class { 'redis::install': require => Package['curl']}
	
	class { 'kibana4': 
		port => '5601',
		host=> 'localhost',
		require => Package['curl']
	}
	
	class { 'nginx': }
	nginx::resource::upstream { 'kibana4': members => ['localhost:5601', ],}
	nginx::resource::vhost { 'kibana4': proxy => 'http://localhost:5601', }
}

