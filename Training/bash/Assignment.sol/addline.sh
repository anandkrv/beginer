#Add a line if not already present in the file
# II'll take a new line as a parameter
# Second parameter is file name
#!/bin/bash
printline="$2"
filename="$1"
echo "print_line=$printline"
echo "file_name=$filename"
if [ -f $filename ]
then
echo "file exists"
grep -q "$printline" "$filename" || echo "$printline" >> "$filename"
echo "line print"
else
echo "the specified file does not exist"
fi
