#!/bin/bash
install_docker() {
	server_ip=$1
	ssh -o StrictHostKeyChecking=no root@${server_ip} "sudo apt-get update"
        ssh -o StrictHostKeyChecking=no root@${server_ip} "docker"  
	if [ $? -eq 0 ]
	then
	  echo "docker allredy install"
	else
	   echo "docker install"
	   ssh -o StrictHostKeyChecking=no root@${server_ip} "curl -sSL https://get.docker.com/ | sh"
	fi
}

copy_docker_image(){
	JENKINS_HOME=$1
	server_ip=$2
	time scp -r -o StrictHostKeyChecking=no ${JENKINS_HOME}/docker.tar root@${server_ip}:~/.
        echo "Load docker images"
	ssh -o StrictHostKeyChecking=no root@${server_ip} "docker load < ~/docker.tar"
	ssh -o StrictHostKeyChecking=no root@${server_ip} " docker tag 89bd1c4685b3 vnc_php_test:latest"
}
 
create_container() {
        container="${1}_Container"
        host_sshport=$2
        container_sshport=$3
        host_vncport=$4
        container_vncport=$5
        host_nginxport=$6
        container_nginxport=$7
        image_name=$8
	server_ip=$9
        ssh -o StrictHostKeyChecking=no root@${server_ip}  "docker run -d --name $container -p ${host_sshport}:${container_sshport} -p ${host_vncport}:${container_vncport} -p ${host_nginxport}:${container_nginxport} ${image_name}"
}


setup_mysql() {
	server_ip=$1
        ssh_port=$2
	JENKINS_HOME=$3
	echo $server_ip  $ssh_port $JENKINS_HOME
	echo "Stop mysql service"
        ssh root@${server_ip} -o StrictHostKeyChecking=no -p ${ssh_port} "service mysql stop"
	echo "Copy database"
	time scp -r -o StrictHostKeyChecking=no -P ${ssh_port} ${JENKINS_HOME}/data/mysql root@${server_ip}:/var/lib
        ssh root@${server_ip} -o StrictHostKeyChecking=no -p ${ssh_port} "chown -R mysql:mysql /var/lib/mysql"
	echo "Copy my.cnf"
        scp -r -o StrictHostKeyChecking=no -P ${ssh_port} ${JENKINS_HOME}/data/my.cnf root@${server_ip}:/etc/mysql
        ssh root@${server_ip} -o StrictHostKeyChecking=no -p ${ssh_port} "chown -R root:root /etc/mysql/my.cnf"
	echo "Start mysql service"
        ssh root@${server_ip} -o StrictHostKeyChecking=no -p ${ssh_port} "service mysql start"
}

copy_files() {
	server_ip=$1
        ssh_port=$2
	JENKINS_HOME=$3
	echo "Copy files"
        ssh root@${server_ip} -o StrictHostKeyChecking=no -p ${ssh_port} "rm -rf /data/files"
        time scp -r -o StrictHostKeyChecking=no -P ${ssh_port} ${JENKINS_HOME}/data/files root@${server_ip}:/data/
        ssh root@${server_ip} -o StrictHostKeyChecking=no -p ${ssh_port} "rm -rf /data/settings.php"
        scp -r -o StrictHostKeyChecking=no -P ${ssh_port} ${JENKINS_HOME}/data/settings.php root@${server_ip}:/data/
        ssh root@${server_ip} -o StrictHostKeyChecking=no -p ${ssh_port} "chown -R www-data /data/files"
}


copy_git_project() {
	server_ip=$1
        ssh_port=$2
        source_dir=$3
        ssh root@${server_ip} -o StrictHostKeyChecking=no -p ${ssh_port} "mkdir -p /usr/share/nginx/www/ProgrammableWeb"
        scp -r -o StrictHostKeyChecking=no -P ${ssh_port} ${source_dir}/. root@${server_ip}:/usr/share/nginx/www/ProgrammableWeb/
}

change_settings() {
	server_ip=$1
        ssh_port=$2
        ssh root@${server_ip} -o StrictHostKeyChecking=no -p ${ssh_port} "cd /usr/share/nginx/www/ProgrammableWeb/sites/default && chown -R www-data:root files && chown root:root settings.php"
        ssh root@${server_ip} -o StrictHostKeyChecking=no -p ${ssh_port} "cd /usr/share/nginx/www/ProgrammableWeb/sites/default && chmod 644 settings.php"
        ssh root@${server_ip} -o StrictHostKeyChecking=no -p ${ssh_port} "cd /data && chown -R www-data:root files && chown root:root settings.php"
        ssh root@${server_ip} -o StrictHostKeyChecking=no -p ${ssh_port} "cd /data && chmod 644 settings.php"
}

copy_setting_files() {
	server_ip=$1
        ssh_port=$2
	JENKINS_HOME=$3
        scp -o StrictHostKeyChecking=no -P ${ssh_port} ${JENKINS_HOME}/data/default root@${server_ip}:/etc/nginx/sites-available
        scp -o StrictHostKeyChecking=no -P ${ssh_port} ${JENKINS_HOME}/data/php.ini root@${server_ip}:/etc/php5/fpm/
        scp -o StrictHostKeyChecking=no -P ${ssh_port} ${JENKINS_HOME}/data/behat.yml root@${server_ip}:/usr/share/nginx/www/ProgrammableWeb/tests/
        scp -o StrictHostKeyChecking=no -P ${ssh_port} ${JENKINS_HOME}/data/composer.json root@${server_ip}:/usr/share/nginx/www/ProgrammableWeb/tests/
}
