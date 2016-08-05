#!/bin/bash
create_branch() {
	GIT_CODEBASE_DIR=$1
	SOURCE_BRANCH_NAME=$2
	TARGET_BRANCH_NAME=$3

	cd ${GIT_CODEBASE_DIR}
	git branch | grep -w ${TARGET_BRANCH_NAME} > /dev/null
	if [ $? -eq 0 ]; then
		echo "Target Branch already exists"
		exit 1
	else
		git checkout ${SOURCE_BRANCH_NAME}
		git branch ${TARGET_BRANCH_NAME}
		echo "New Branch Created ${TARGET_BRANCH_NAME}"
		git checkout ${TARGET_BRANCH_NAME}
		git push origin ${TARGET_BRANCH_NAME}
	fi
}

create_tag() {
	GIT_CODEBASE_DIR=$1
        BRANCH_NAME=$2
        cd ${GIT_CODEBASE_DIR}
	git checkout master
	git checkout ${BRANCH_NAME}
        git tag "deleted_${BRANCH_NAME}"
        git push origin "deleted_${BRANCH_NAME}"
}

delete_branch() {
	GIT_CODEBASE_DIR=$1
        BRANCH_NAME=$2
	cd ${GIT_CODEBASE_DIR}

	git ls-remote --heads | grep ${BRANCH_NAME}

	if [ "0" = "$?" ];then
		echo "Creating a tag and then deleting the branch"
		create_tag ${GIT_CODEBASE_DIR} ${BRANCH_NAME}
		git checkout master
		git branch -D ${BRANCH_NAME}
		git push origin --delete ${BRANCH_NAME}
	else
		echo "${BRANCH_NAME} branch doesn't exists, please check!!!!!!!"
	fi
}

checkout_branch() {
	BRANCH=$1

	git checkout ${BRANCH}
	git pull origin ${BRANCH}

	if [ "$?" == "1" ]; then
		echo "Branch ${BRANCH} doesn't exist please verify...."
		exit 1
	fi
}

generate_email_list_for_conflict_files() {
        SOURCE_BRANCH=$1
        TARGET_BRANCH=$2
        GIT_CODEBASE_DIR=$3

#	echo "" > /tmp/conflictFilesAuthorsEmail.lst
	rm -f /tmp/conflictFilesAuthorsEmail.txt
        touch /tmp/conflictFilesAuthorsEmail.txt
	echo "EMAIL=" >> /tmp/conflictFilesAuthorsEmail.txt
	while read conflictFile;do
		echo "Finding author fo conflicting file $conflictFile"
		AUTHOR_EMAIL=`get_last_author_email_for_file ${TARGET_BRANCH} ${conflictFile} ${GIT_CODEBASE_DIR}`
		echo "Author email is ${AUTHOR_EMAIL}"
		sed -i "s/$/${AUTHOR_EMAIL},/" "/tmp/conflictFilesAuthorsEmail.txt"
		#echo ${AUTHOR_EMAIL} >> /tmp/conflictFilesAuthorsEmail.lst
	done < /tmp/conflictfiles.txt
}

merge_checkedout_branches() {
	SOURCE_BRANCH=$1
        TARGET_BRANCH=$2
	GIT_CODEBASE_DIR=$3

	git merge ${SOURCE_BRANCH}

	if [ "$?" == "1" ]; then
                echo "Merge from ${SOURCE_BRANCH} to ${TARGET_BRANCH} failed, reverting merge and exiting!!!!!"
		echo "FAIL" > "/var/lib/jenkins/jobs/${TARGET_BRANCH}MultiJob/mergestatus.txt"
		echo "Merge from ${SOURCE_BRANCH} to ${TARGET_BRANCH} FAILED" >> "/var/lib/jenkins/jobs/merge_master_to_feature/branchmerges"
		git diff --name-only --diff-filter=U > /tmp/conflictfiles.txt
		git merge --abort
		generate_email_list_for_conflict_files ${SOURCE_BRANCH} ${TARGET_BRANCH} ${GIT_CODEBASE_DIR}
#		sed -i "s/$/${mail},/" "/var/lib/jenkins/jobs/merge_master_to_feature/email.properties"
		exit 1
	else 
		echo "Merge from ${SOURCE_BRANCH} to ${TARGET_BRANCH} succeeded, commiting the changes"
		echo "SUCCESS" > "/var/lib/jenkins/jobs/${TARGET_BRANCH}MultiJob/mergestatus.txt"
		echo "Merge from ${SOURCE_BRANCH} to ${TARGET_BRANCH} SUCCEEDED" >> "/var/lib/jenkins/jobs/merge_master_to_feature/branchmerges"
		git push origin ${TARGET_BRANCH}
		sleep 2m
        fi
}

merge_branch() {
	SOURCE_BRANCH=$1
	TARGET_BRANCH=$2
	GIT_CODEBASE_DIR=$3

	echo "I'll be merging ${SOURCE_BRANCH} to ${TARGET_BRANCH} under ${GIT_CODEBASE_DIR}"

	cd ${GIT_CODEBASE_DIR}
	checkout_branch ${SOURCE_BRANCH}

	checkout_branch ${TARGET_BRANCH}

	merge_checkedout_branches ${SOURCE_BRANCH} ${TARGET_BRANCH} ${GIT_CODEBASE_DIR}
}

get_branch_author_email() {
	BRANCH_NAME=$1

	COMMIT_ID=`git reflog show --no-abbrev $BRANCH_NAME | tail -n1 | awk '{print $1}'`
	AUTHOR_EMAIL=`git --no-pager log -1 --pretty=format:"%ae" $COMMIT_ID`
	echo $AUTHOR_EMAIL
}	


get_last_author_email_for_file() {
	BRANCH_NAME=$1
	FILE_PATH=$2
	WORKING_DIR=$3

	cd ${WORKING_DIR}
	git checkout ${BRANCH_NAME}
	AUTHOR_EMAIL=`git log -n 1 --pretty=format:%ae -- ${FILE_PATH}`
	echo $AUTHOR_EMAIL
}

get_committers_email() {
	BRANCH_NAME=$1
	ID=$2
	PATH_TO_CHANGE_LOG="/var/lib/jenkins/jobs/${BRANCH_NAME}MultiJob/builds/${ID}"
	TMP_FILE="/tmp/${BRANCH_NAME}mail.txt"
	[ -s ${PATH_TO_CHANGE_LOG}/changelog.xml ]
	if [ $? -eq 1 ]
	then
		rm -f ${TMP_FILE}
		touch ${TMP_FILE}
		echo "EMAIL=" >> ${TMP_FILE}	
	else
		grep committer ${PATH_TO_CHANGE_LOG}/changelog.xml | cut -d "<" -f 2| cut -d ">" -f 1 | uniq > ${TMP_FILE}
		sed -i ':a;N;$!ba;s/\n/,/g' ${TMP_FILE}
		sed -i "s/^/EMAIL=/" ${TMP_FILE}
	fi
}
