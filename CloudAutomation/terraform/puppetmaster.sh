{
#!/bin/bash
ENVIRONMENT=$1
COMPONENT=$2
AZ=$3
HOSTNAME=${ENVIRONMENT}.${COMPONENT}.az.${AZ}.xebia.training.com
sudo sh -c "cat >/etc/hosts << EOL
127.0.0.1	${ENVIRONMENT}.${COMPONENT}.az.${AZ}.xebia.training.com localhost
# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
EOL"

sudo sh -c "echo \"${ENVIRONMENT}.${COMPONENT}.az.${AZ}.xebia.training.com\" > /etc/hostname"
sudo hostname --file /etc/hostname
sudo hostname ${HOSTNAME}

# NTP
sudo ntpdate pool.ntp.org

# Install PuppetMaster
wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
sudo dpkg -i puppetlabs-release-trusty.deb
sudo apt-get update -y
sudo apt-get install puppetmaster-passenger -y

# Stop Apache service
sudo service apache2 stop

# Create PuppetMaster Version Locking file
sudo bash -c "echo Package: puppet puppet-common puppetmaster-passenger > /etc/apt/preferences.d/00-puppet.pref"
sudo bash -c "echo Pin: version 3.8.6 >> /etc/apt/preferences.d/00-puppet.pref"
sudo bash -c "echo Pin-Priority: 501 >> /etc/apt/preferences.d/00-puppet.pref"

# Delete Old Certs
sudo rm -rf /var/lib/puppet/ssl

# Modifying puppet.conf
sudo sed -i '7 s/^/#/' /etc/puppet/puppet.conf
sudo sed -i "8i certname = $HOSTNAME" /etc/puppet/puppet.conf
sudo sed -i "9i dns_alt_names = puppet,$HOSTNAME" /etc/puppet/puppet.conf
sudo sed -i "10i environmentpath  = /etc/puppet/environments/" /etc/puppet/puppet.conf


# Generating new Certs
sudo bash -c "timeout 30 puppet master --verbose --no-daemonize"

# Start Apache
sudo service apache2 start

sudo sh -c "echo '*' > /etc/puppet/autosign.conf"

sudo sh -c 'cat >/etc/puppet/hiera.yaml << EOL
---
:backends:
  - yaml
:yaml:
  :datadir: "/etc/puppet/environments/%{::environment}/hieradata"
:hierarchy:
   - "%{clientcert}"
   - "%{::fqdn}"
   - common
:logger: puppet
:merge_behavior:
   - deeper
EOL'

sudo sh -c "cat > /etc/puppet/r10k.yaml << EOL
---
cachedir: '/var/cache/r10k'
sources:
  traning:
    remote: 'https://github.com/OpsTree/CloudPuppet.git'
    basedir: '/etc/puppet/environments'
EOL"
sudo apt-get install git -y
sudo gem install r10k -v 1.1.4
cd /etc/puppet/
sudo r10k deploy environment -v
cd

sudo service apache2 restart
}
