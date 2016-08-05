# II'll take a directory name as a parameter and will list out all the files 
#Take second parameter is matching to a pattern.



#!/bin/bash
directory="$1"
matching="$2"
echo "directory=$directory"
echo "matching_pattern=$matching"
if [ -d  $directory ]
then
   echo "directory is exists"
   echo "print matching pattern"
   ls -lrt $list | grep $matching
else
      echo "directory is not exists"
fi








