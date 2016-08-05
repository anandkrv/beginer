#!/bin/bash
git_last_commit(){
WORKSPACE=$1
BRANCH_NAME=$2

cd $WORKSPACE
git log -1 --stat | grep commit | cut -d ' ' -f2 >> /tmp/last_commit_id
cd
}

compare_commit_id(){

compare_id=`tail -n 2 /tmp/last_commit_id | uniq | wc -l`
if [ $compare_id -eq 1 ]
then
  echo "NO new code is commit"
else
  echo "new code id commit"
  #java -jar ${JENKINS_CLI_JAR} -s $JENKINS_URL build ${BRANCH_NAME}MultiJob
fi
}
