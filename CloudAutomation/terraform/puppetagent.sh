{
#!/bin/bash
ENVIRONMENT=$1
COMPONENT=$2
AZ=$3
cat >/etc/hosts << EOL
127.0.0.1    ${ENVIRONMENT}.${COMPONENT}.az.${AZ}.xebia.training.com localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
EOL

cat >/etc/sysconfig/network << EOL
HOSTNAME=${ENVIRONMENT}.${COMPONENT}.az.${AZ}.xebia.training.com
NETWORKING=yes
EOL

hostname ${ENVIRONMENT}.${COMPONENT}.az.${AZ}.xebia.training.com

sudo /etc/init.d/network restart
sudo rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
sudo yum install puppet -y
sudo puppet resource package puppet-server ensure=latest
puppet agent --enable

cat >/etc/puppet/puppet.conf << EOL 
[main]
	logdir=/var/log/puppet
	vardir=/var/lib/puppet
	ssldir=/var/lib/puppet/ssl
	rundir=/var/run/puppet
	factpath=$vardir/lib/facter
	environment=${ENVIRONMENT}
	listen=true

[master]
	ssl_client_header = SSL_CLIENT_S_DN 
	ssl_client_verify_header = SSL_CLIENT_VERIFY

[agent]
	server=dev.puppet.az.b.xebia.training.com
	report=true
EOL
}
