# II'll take a file name as a parameter and will remove file 
#Validationsve 
# 1.) The filename should be passed as first argument



#!/bin/bash
echo "file_name=$1"
if [ -f  $1 ]
then
rm -rf $1
   echo "File is remove"
else
      echo "File is not exists"
fi



