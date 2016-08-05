#Count number of lines in a file
#II'll take a file name as a parameter and count number of lines 


#!/bin/bash
filename=$1
echo filename="$filename"
if [ -f $filename ]
then
   echo "file  exists"
echo "no of lines"
wc -l $filename 
else
echo "the specified file  does not exist"
fi


