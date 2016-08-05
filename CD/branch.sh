#!/bin/bash
branch_name="$1"
echo "name=$branch_name"
#if [ -z  $branch_name ]
#then
 #  echo "branch is exists"
#echo "change the branch name"
#else
#git branch $branch_name
 # echo  "Created  branch"
#fi
 #if [git branch -a $branch_name ]; then
          #echo  "Branch already exists"
        #else
         # `git branch $branch_name`
         # echo  "Created  branch"
        #fi
if [ `git branch | grep $branch_name` ]
then
    echo "Branch named $branch_name already exists"
else
`git branch $branch_name`
    echo " Created Branch "
fi
 

