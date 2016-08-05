#Get the line at a specified line number
#II'll take a file name as a parameter 
#Second parameter is line number
#Then check file is exist or not  


#!/bin/bash
printfile="$1"
linenumber="$2"
echo "print_file=$printfile" 
echo "linenumber=$linenumber"
if [ -f $printfile ]
then
   echo "file  exists and print the line"
sed -ne "${linenumber}p" $printfile
else
echo "the specified file does not exist"
fi

