#!/bin/bash
function replaceTextInFile(){
	SOURCE_FILE=$1
	SOURCE_TXT=$2
	TARGET_TXT=$3


	sed -i s/${SOURCE_TXT}/${TARGET_TXT}/ $SOURCE_FILE
}

findLineNumber(){
	PATTERN=$1
	FILE_PATH=$2
	linenumber=$(grep -nFx ${PATTERN} ${FILE_PATH} | sed 's/^\([0-9]\+\):.*$/\1/')
	echo $linenumber
}

deleteLine() {
	LINE_NUM=$1
	FILE_PATH=$2
	sed -i "${LINE_NUM}d" ${FILE_PATH}
}
