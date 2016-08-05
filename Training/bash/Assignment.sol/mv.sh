#Move a file from source folder to target folder

# II'll take a directory name as a parameter 
#Validationsve 
# 1.) The directory should be passed as first argument
# 2.) The directory should not already exists



#!/bin/bash
source_folder="$1"
target_folder="$2"
file_name="$3"
echo "source folder=$source_folder"
echo "target folder=$target_folder"
echo "file name =$file_name"
if [ -d  $source_folder ]
then
   echo "directory is exists"
else
      echo "directory is not exists"
fi
if [ -d  $target_folder ]
then
   echo "directory is exists"

else
      echo "directory is not exists"
fi
if [ -f  $file_name ]
then
   echo "File  exists "
mv $file_name  $target_folder
echo "file move source folder to target folder"
else
      echo "File is not exists"
fi




