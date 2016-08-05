#Get the line at a specified line number
#II'll take a file name as a parameter 
#Second parameter is line number parameter
#third parameter is print word  parameter


#!/bin/bash
printfile="$1"
linenumber="$2"
printword="$3"
echo "print_file=$printfile" 
echo "linenumber=$linenumber"
echo "printword=$printword"
if [ -f $printfile ]
then
   echo "file  exists and print the line"
sed -ne "${linenumber}p" $printfile | awk  '{print$ '$printword' }'
else
echo "the specified file does not exist"
fi

