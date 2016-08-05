#Create a directory
# II'll take a directory name as a parameter and will directory
#Validationsve 
# 1.) The directory should be passed as first argument
# 2.) The directory should not already exists



#!/bin/bash
echo "dir_name=$1"
if [ -d  $1 ]
then
   echo "directory already exists so change the directory"
else
mkdir $1
      echo "directory is created"
fi

