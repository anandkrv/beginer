# Delete files older then N days
#II'll take a directory  name as a parameter 
#Second parameter is days parameter



#!/bin/bash
dirname="$1"
days="$2"

echo "print_dir=$dirname" 
echo "days=$days"
if [ -d $dirname ]
then
   echo "file directory  exists"
find $dirname  -type f -ctime $days | rm -rf
else
echo "the specified directory does not exist"
fi


