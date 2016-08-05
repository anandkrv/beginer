#Return the list of all files with name and their size in a directory
#II'll take a directory name  as a parameter and list out  of  directory file 



#!/bin/bash
directory="$1"
echo "directory= $directory"
if [ -d  $directory ]
then
   echo "directory is exists"
echo "all files with name and their size in a directory"
ls -l $directory | awk '{print$9"       "$5}'

else
      echo "directory is not exists"
fi

