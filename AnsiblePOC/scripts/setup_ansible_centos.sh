#!/bin/bash
Install_Ansible() {
	ansible --version
	if [ $? -eq 0 ]; then
		echo "****************************"			
		echo "Ansible is already installed"
		echo "****************************"
	else
		
		wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
		sudo yum -y update
		sudo rpm -Uvh epel-release-latest-6.noarch.rpm
		sudo yum -y install ansible
	fi

}
Install_Ansible
