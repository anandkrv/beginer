#Remove a directory

# II'll take a directory name as a parameter and will remove directory 
#Validationsve 
# 1.) The directory name  should be passed as first argument


#!/bin/bash
echo "file_name=$1"
if [ -d  $1 ]
then
rm -rf $1
   echo "directory is remove"
else
      echo "directory is not exists"
fi




