#Print the top N lines after sorting the content of file in Descending order
# II'll take a file name as a parameter and sorting the file content in Descending order
# Second parameter is print the top N line
 

#!/bin/bash
echo "file_name=$1"
sort -n -r $1 | head -$2


