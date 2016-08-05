#!/bin/bash
{
Install_Ansible() {
	ansible --version
	if [ $? -eq 0 ]; then
		echo "****************************"			
		echo "Ansible is already installed"
		echo "****************************"
	else
		sudo apt-get install software-properties-common
		sudo apt-add-repository ppa:ansible/ansible
		sudo apt-get update
		sudo apt-get -y install ansible
	fi

	mkdir -p ~/Myplaybook/
}
Install_Ansible
}
