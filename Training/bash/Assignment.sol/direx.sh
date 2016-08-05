#Check if a directory exists

# II'll take a directory name as a parameter 
#Validationsve 
# 1.) The directory should be passed as first argument
# 2.) The directory should not already exists



#!/bin/bash
echo "dir_name=$1"
if [ -d  $1 ]
then
   echo "directory is exists"
else
      echo "directory is not exists"
fi

