#Check if a file exists or not
# II'll take a file name as a parameter and will create an empty file 
#Validationsve 
# 1.) The filename should be passed as first argument
# 2.) The file should not already exists



#!/bin/bash
echo "file_name=$1"
if [ -f  $1 ]
then
   echo "File  exists "
else
      echo "File is not exists"
fi



