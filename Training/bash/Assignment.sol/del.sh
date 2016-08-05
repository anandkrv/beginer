#Delete a line number from a file
#II'll take a file name as a parameter 
#Second parameter is line number 


#!/bin/bash
echo "print_file $1" 
echo "line_number $2"
if [ -f  $1 ]
then
   echo "file is exists"
sed -i "${2}d" $1
echo "line is delete"
else
echo "file is not exists"
fi

