#!/bin/bash
source /var/lib/jenkins/JobScripts/shell_functions.sh
source /var/lib/jenkins/JobScripts/jenkins.properties

createJobConfigFromTemplate(){
    path_job_template=$1
    JOB_NAME=$2
    TARGET=$3
    IP=$4

    cp "${path_job_template}" "${TARGET}"
    replaceTextInFile ${TARGET} {feature_branch} ${JOB_NAME}
    replaceTextInFile ${TARGET} {SERVER_IP} ${IP}
}

createJob(){
        JOB_NAME=$1
        JOB_CONFIG=$2

        echo " INFO : Creating Job : $JOB_NAME "
        java -jar ${JENKINS_CLI_JAR} -s $JENKINS_URL create-job ${JOB_NAME} < ${JOB_CONFIG}

        export RC=$?
        if [ $RC -ne 0 ]; then
                echo " Error While Creating JOB : $JOB_NAME !!! "
                echo " Failed with Error Code : $RC "
                return 1
        else
                echo " INFO : Created Job : $JOB_NAME "
                return 0
        fi
}

deleteJob(){
	JOB_NAME=$1
	echo " INFO :Deleting Job : $JOB_NAME "
	java -jar ${JENKINS_CLI_JAR} -s $JENKINS_URL delete-job ${JOB_NAME}
	export RC=$?
        if [ $RC -ne 0 ]; then
                echo " Error While deleting JOB : $JOB_NAME !!! "
                echo " Failed with Error Code : $RC "
                return 1
        else
                echo " INFO : deleted Job : $JOB_NAME "
		echo "INFO : Deleting workspace at /var/lib/jenkins/workspace/${JOB_NAME}"
		rm -rf /var/lib/jenkins/workspace/${JOB_NAME}
                return 0
        fi
}

build_job() {
        JOB_TO_BUILD=$1
        NAME_OF_BRANCH=$2
	echo $JOB_TO_BUILD $NAME_OF_BRANCH
        java -jar ${JENKINS_CLI_JAR} -s $JENKINS_URL build ${JOB_TO_BUILD} -p BRANCH_NAME=${NAME_OF_BRANCH} -s
	echo "*****"
	export RC=$?
        if [ $RC -ne 0 ]; then
                echo " Error While building JOB : $JOB_TO_BUILD !!! "
                echo " Failed with Error Code : $RC "
                return 1
        else
                echo " INFO : Build Job : $JOB_TO_BUILD "
                return 0
        fi
}

build_merge() {
        JOB_TO_BUILD=$1
	SOURCE=$2
	TARGET=$3
        WORK_DIREC=$4
        java -jar ${JENKINS_CLI_JAR} -s $JENKINS_URL build ${JOB_TO_BUILD} -p SOURCE_BRANCH=${SOURCE} -p TARGET_BRANCH=${TARGET} -p WORKING_DIR=${WORK_DIREC}
        export RC=$?
        if [ $RC -ne 0 ]; then
                echo " Error While building JOB : $JOB_TO_BUILD !!! "
                echo " Failed with Error Code : $RC "
                return 1
        else
                echo " INFO : Build Job : $JOB_TO_BUILD ${SOURCE} -> ${TARGET}"
                return 0
        fi
}


getXmlElement(){
        ELEMENT_XPATH=$1
        XML_FILE_PATH=$2
        value="$(echo "cat ${ELEMENT_XPATH}/text()" | xmllint --nocdata --shell ${XML_FILE_PATH} | sed -n 3p)"
        echo $value
}

get_job_status() {
	JOB=$1
	curl -X post http://104.236.113.75:8080/job/${JOB}/lastBuild/api/xml -u ${USERNAME}:${PASSWORD} > /tmp/${JOB}_tmp.xml
	grep -q html /tmp/${JOB}_tmp.xml
	if [ $? -eq 0 ]
	then
		status="NOT-KNOWN"
		echo $status
	else
		building=`getXmlElement /freeStyleBuild/building /tmp/${JOB}_tmp.xml`
		if [ "${building}" = "true" ]; then
			status="IN-PROGRESS"
			echo $status
		else
			status=`getXmlElement /freeStyleBuild/result /tmp/${JOB}_tmp.xml`
			echo $status
		fi
	fi
}

get_job_status_multijob() {
        JOB=$1
        curl -X post http://104.236.113.75:8080/job/${JOB}/lastBuild/api/xml -u ${USERNAME}:${PASSWORD} > /tmp/${JOB}_tmp.xml
	grep -q html /tmp/${JOB}_tmp.xml
        if [ $? -eq 0 ]
        then
                status="NOT-KNOWN"
                echo $status
        else
        	building=`getXmlElement /multiJobBuild/building /tmp/${JOB}_tmp.xml`
        	if [ "${building}" = "true" ]; then
                	status="IN-PROGRESS"
                	echo $status
        	else
                	status=`getXmlElement /multiJobBuild/result /tmp/${JOB}_tmp.xml`
                	echo $status
        	fi
	fi
}
