#Use this command to install java
puppet module install puppetlabs-java

#install java
include java

#java module installs the correct jdk or jre package
class { 'java':
  distribution => 'jre',
}
