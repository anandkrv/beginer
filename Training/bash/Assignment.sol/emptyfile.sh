# II'll take a file name as a parameter and will create an empty file 
#Validationsve 
# 1.) The filename should be passed as first argument
# 2.) The file should not already exists



#!/bin/bash
echo "file_name=$1"
if [ -f  $1 ]
then
   echo "File already exists so change the file name"
else
touch $1
      echo "File is create"
fi






