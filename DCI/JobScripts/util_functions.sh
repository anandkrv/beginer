#!/bin/bash
source /var/lib/jenkins/JobScripts/jenkins_functions.sh
source /var/lib/jenkins/JobScripts/git_functions.sh
check_active_port(){
	RANGE_MIN=$1
	RANGE_MAX=$2
	port=`shuf -i $RANGE_MIN-$RANGE_MAX -n 1`
	while :
	do
		grep -wq $port /var/lib/jenkins/portlookup/portlookup.txt
		if [ $? -eq 0 ]
          	then
              		port=`shuf -i $RANGE_MIN-$RANGE_MAX -n 1`
          	else
              		break
          	fi
	done
	echo ${port}	
}

list_used_ports() {
	netstat -ant | awk '{ print $4}' | rev |cut -d ":" -f1|rev|uniq -u | grep -o '[0-9]*'>/var/lib/jenkins/portlookup/portlookup.txt
        [ -s /var/lib/jenkins/portlookup/portlookup.txt ]
        if [ $? -eq 1 ]; then
        	echo "10">>/var/lib/jenkins/portlookup/portlookup.txt
        fi
}

assign_ports(){
	serv_name=$1
	grep -wq $serv_name /var/lib/jenkins/portlookup/server_mapping
	if [ $? -eq 0 ]; then
		echo "This server name already exists."
		exit 1
	else
      		list_used_ports
		addsshport=`check_active_port 8000 8999` 
		addvncport=`check_active_port 7000 7999`
		addnginxport=`check_active_port 9000 9999`

		echo "$serv_name $addsshport $addvncport $addnginxport">>/var/lib/jenkins/portlookup/server_mapping
	fi
}

deleteServer() {
	server_name=$1
	grep -wq $server_name /var/lib/jenkins/portlookup/server_mapping
	if [ $? -eq 0 ]
	then
    		linenum=$(grep -nw $server_name /var/lib/jenkins/portlookup/server_mapping|sed 's/^\([0-9]\+\):.*$/\1/')
    		sed -i "${linenum}d" /var/lib/jenkins/portlookup/server_mapping
	else
    		echo "No server with this name"
		exit 1
	fi
}

getPort(){
	servername=$1
	find_port=$2
	port_value=$(grep -w $servername /var/lib/jenkins/portlookup/server_mapping | cut -d " " -f${find_port})
	echo $port_value
}

getSSHPort(){
	name=$1
	grep -wq $name /var/lib/jenkins/portlookup/server_mapping
	if [ $? -eq 0 ]
	then
		sshport=`getPort ${name} 2`
		echo $sshport
	else
		echo "This server does not exist"
		exit 1
	fi
}

getVNCPort(){
	name=$1
        grep -wq $name /var/lib/jenkins/portlookup/server_mapping
        if [ $? -eq 0 ]
        then
                vncport=`getPort ${name} 3`
		echo $vncport
        else
                echo "This server does not exist"
                exit 1
        fi
}

getNginxPort(){
        name=$1
        grep -wq $name /var/lib/jenkins/portlookup/server_mapping
        if [ $? -eq 0 ]
        then
                nginxport=`getPort ${name} 4`
                echo $nginxport
        else
                echo "This server does not exist"
                exit 1
        fi
}


mergeBranchToActiveBranches() {
	SOURCE_BRANCH=$1
	WORKING_DIR=$2

	TARGET_BRANCHES=`grep Server /var/lib/jenkins/portlookup/server_mapping | cut -d " " -f1`
	rm -f "/var/lib/jenkins/jobs/merge_master_to_feature/branchmerges"
	touch "/var/lib/jenkins/jobs/merge_master_to_feature/branchmerges"
	echo "EMAIL=" >> "/var/lib/jenkins/jobs/merge_master_to_feature/email.properties"
	for TARGET_BRANCH in ${TARGET_BRANCHES}; do
		TARGET_BRANCH=`echo ${TARGET_BRANCH/_Server}`
		build_merge merge_source_target ${SOURCE_BRANCH} ${TARGET_BRANCH} /var/lib/jenkins/workspace/merge_source_target 
	done
}

check_for_new_branches() {
	GIT_ADDRESS=$1
	git ls-remote --heads ${GIT_ADDRESS} | cut -d/ -f3 | sort > /var/lib/jenkins/branch_changes/branch_list_latest
	comm -3 /var/lib/jenkins/branch_changes/branch_list /var/lib/jenkins/branch_changes/branch_list_latest | sed 's/^\t//' > /var/lib/jenkins/branch_changes/branches
	[ -s /var/lib/jenkins/branch_changes/branches ]
	if [ $? -eq 1 ]; then
		mv /var/lib/jenkins/branch_changes/branch_list_latest /var/lib/jenkins/branch_changes/branch_list
		echo "No new branches created"
        else
		mv /var/lib/jenkins/branch_changes/branch_list_latest /var/lib/jenkins/branch_changes/branch_list
		while read -r line
		do
			name=$line
			echo "Running setup feature branch job for new branch ${name}"
			BRANCH_OWNER_EMAIL=$(get_branch_author_email $name)
			echo "BRANCH_OWNER_EMAIL=${BRANCH_OWNER_EMAIL}" > /var/lib/jenkins/branch_changes/branchOwner.email
			build_job Test_SetupFeatureBranch ${name}
		done < /var/lib/jenkins/branch_changes/branches
	fi
}

check_branch() {
	branch=$1
	grep -Fx ${branch} /var/lib/jenkins/branch_changes/branch_list
	if [ $? -eq 0 ]
	then
		echo "Branch already exist"
		exit 1
	fi
}

#setup_mysql() {
#	ssh_port=$1
#	ssh root@localhost -o StrictHostKeyChecking=no -p ${ssh_port} "service mysql stop"
#	scp -r -o StrictHostKeyChecking=no -P ${ssh_port} /var/lib/jenkins/data/mysql root@localhost:/var/lib
#	ssh root@localhost -o StrictHostKeyChecking=no -p ${ssh_port} "chown -R mysql:mysql /var/lib/mysql"
#	scp -r -o StrictHostKeyChecking=no -P ${ssh_port} /var/lib/jenkins/data/my.cnf root@localhost:/etc/mysql
#	ssh root@localhost -o StrictHostKeyChecking=no -p ${ssh_port} "chown -R root:root /etc/mysql/my.cnf"
#	ssh root@localhost -o StrictHostKeyChecking=no -p ${ssh_port} "service mysql start"
#}

#copy_git_project() {
#	ssh_port=$1
#	source_dir=$2
#	ssh root@localhost -o StrictHostKeyChecking=no -p ${ssh_port} "mkdir -p /usr/share/nginx/www/ProgrammableWeb"
#	scp -r -o StrictHostKeyChecking=no -P ${ssh_port} ${source_dir}/. root@localhost:/usr/share/nginx/www/ProgrammableWeb
#	ssh root@localhost -p ${ssh_port} "cd /usr/share/nginx/www/ && mv workspace ProgrammableWeb"
#}

#copy_files() {
#	ssh_port=$1
 #       ssh root@localhost -o StrictHostKeyChecking=no -p ${ssh_port} "rm -rf /data/files"
 #       scp -r -o StrictHostKeyChecking=no -P ${ssh_port} /var/lib/jenkins/data/files root@localhost:/data/
 #       ssh root@localhost -o StrictHostKeyChecking=no -p ${ssh_port} "rm -rf /data/settings.php"
 #       scp -r -o StrictHostKeyChecking=no -P ${ssh_port} /var/lib/jenkins/data/settings.php root@localhost:/data/
 #       ssh root@localhost -o StrictHostKeyChecking=no -p ${ssh_port} "chown -R www-data /data/files"
#	scp -r -P ${ssh_port} /var/lib/jenkins/data/files root@localhost:/usr/share/nginx/www/ProgrammableWeb/sites/default/
#	scp -r -P ${ssh_port} /var/lib/jenkins/data/settings.php root@localhost:/usr/share/nginx/www/ProgrammableWeb/sites/default/
#}

#change_settings() {
#	ssh_port=$1
#	ssh root@localhost -o StrictHostKeyChecking=no -p ${ssh_port} "cd /usr/share/nginx/www/ProgrammableWeb/sites/default && chown -R www-data:root files && chown root:root settings.php"
#	ssh root@localhost -o StrictHostKeyChecking=no -p ${ssh_port} "cd /usr/share/nginx/www/ProgrammableWeb/sites/default && chmod 644 settings.php"
#	ssh root@localhost -o StrictHostKeyChecking=no -p ${ssh_port} "cd /data && chown -R www-data:root files && chown root:root settings.php"
#	ssh root@localhost -o StrictHostKeyChecking=no -p ${ssh_port} "cd /data && chmod 644 settings.php"
#}

#copy_setting_files() {
#	ssh_port=$1
#	scp -o StrictHostKeyChecking=no -P ${ssh_port} /var/lib/jenkins/data/default root@localhost:/etc/nginx/sites-available
#	scp -o StrictHostKeyChecking=no -P ${ssh_port} /var/lib/jenkins/data/php.ini root@localhost:/etc/php5/fpm/
#	scp -o StrictHostKeyChecking=no -P ${ssh_port} /var/lib/jenkins/data/behat.yml root@localhost:/usr/share/nginx/www/ProgrammableWeb/tests/
#	scp -o StrictHostKeyChecking=no -P ${ssh_port} /var/lib/jenkins/data/composer.json root@localhost:/usr/share/nginx/www/ProgrammableWeb/tests/
#}
