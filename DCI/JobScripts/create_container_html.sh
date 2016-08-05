#!/bin/bash
source /var/lib/jenkins/JobScripts/jenkins_functions.sh
source /var/lib/jenkins/JobScripts/util_functions.sh

createCell() {
	cellText=$1
	htmlFile=$2

	echo "Writing $cellText in $htmlFile"	
	echo "<td>" >> $htmlFile
	echo $cellText >> $htmlFile
	echo "</td>" >> $htmlFile
}

createCellFromFileContent() {
        filePath=$1
        htmlFile=$2

	echo "writing below content in $htmlFile"
	cat $filePath

        echo "<td>" >> $htmlFile
        cat $filePath >> $htmlFile
	if [ "$?" == "1" ]; then
		echo "Not Available" >> $htmlFile
	fi
        echo "</td>" >> $htmlFile

}

createCellFromJobStatus() {
	jobName=$1
	echo $jobName
        html=$2
	get_job_status $jobName
        jobStatus=`get_job_status $jobName`
	echo "Status of job $jobName is $jobStatus"
	echo "<td>" >> $htmlFile
        echo "<a href='${JENKINS_URL}job/${jobName}/'>${jobStatus}</a>" >> $htmlFile
        echo "</td>" >> $htmlFile
}

createCellFromMultiJobStatus() {
        jobName=$1
	echo $jobName
        html=$2
        jobStatus=`get_job_status_multijob $jobName`
	echo "<td>" >> $htmlFile
        echo "<a href='${JENKINS_URL}job/${jobName}/'>${jobStatus}</a>" >> $htmlFile
        echo "</td>" >> $htmlFile
}

createExecuteWrapperJobButton(){
	htmlFile=$1
	branch=$2
	echo "<td>" >> $htmlFile
	echo "<form method='post' action='${JENKINS_URL}job/${branch}MultiJob/build?delay=0sec'><input type='hidden' name='user' value='${USERNAME}:${PASSWORD}'/><input type='submit' value='Run tests' /></form>" >> $htmlFile
	echo "</td>" >> $htmlFile
}

create_container_html() {
filename=$1
path=$2
echo "<html>" > $path
echo "<head>" >> $path
echo "<title>" >> $path
echo "Server mappings info" >> $path
echo "</title></head>" >> $path
echo "<body>" >> $path
echo "<table width='100%' border='2'>" >> $path
echo "<tr>" >> $path
	echo "<th> Server name </th><th> SSH Port </th><th> VNC Port </th><th> Web Server Port </th><th> Wrapper Code Quality Status </th><th> Merge Status </th><th> Unit Tests Status </th><th> Functional Test Status </th><th> Static Code Analysis Status </th></tr>" >> $path
while read -r line
do
	name=$line
	echo "<tr>" >> $path
	createCell `echo "$name" | cut -d " " -f1` $path

	createCell `echo "$name" | cut -d " " -f2` $path

	createCell `echo "$name" | cut -d " " -f3` $path

	createCell `echo "$name" | cut -d " " -f4` $path

	current_server=`echo "$name" | cut -d " " -f1`
	current_branch=`echo ${current_server/_Server}`

	createCellFromMultiJobStatus "${current_branch}MultiJob" $path

	if [ ! -f "/var/lib/jenkins/jobs/${current_branch}MultiJob/mergestatus.txt" ]; then
                touch "/var/lib/jenkins/jobs/${current_branch}MultiJob/mergestatus.txt" 
		echo "NoMergesYet" >> "/var/lib/jenkins/jobs/${current_branch}MultiJob/mergestatus.txt"
        fi

	createCellFromFileContent /var/lib/jenkins/jobs/${current_branch}MultiJob/mergestatus.txt $path

	createCellFromJobStatus "${current_branch}UnitTest" $path
	
	createCellFromJobStatus "${current_branch}FunctionalTest" $path
	
	createCellFromJobStatus "${current_branch}StaticCodeAnalysis" $path

	createExecuteWrapperJobButton $path ${current_branch}
#	echo "</table>" >> $path
#	echo "</td>" >> $path
	echo "</tr>" >> $path
done < "$filename"
echo "</table>" >> $path
echo "</body>" >> $path
echo "</html>" >> $path
}
