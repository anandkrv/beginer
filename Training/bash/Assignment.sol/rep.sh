#replacing a content from another
#II'll take a file name as a parameter 
#Second parameter is replace world parameter
#third parameter is replaced world  parameter


#!/bin/bash
printfile="$1"
replaceword="$2"
replacedword="$3"
echo "print_file=$printfile" 
echo "word=$replaceword"
echo "replaceword=$replacedword"
if [ -f $printfile ]
then
   echo "file  exists"
sed 's/'$replaceword/$replacedword'/g' $printfile
else
echo "the specified file does not exist"
fi



