#!/bin/bash

file=$1
ext=$2

exists=$(ls $file)
noext=$(ls $file | grep "\.\w*")

if [[ -z $file || -z $exists ]]
then
        echo "Input file not found"
        exit 1
elif [[ -z $ext ]]
then
        echo "Ext is null"
        exit 1
elif [[ -z $noext ]]
then 
	echo "File without ext"
	exit 1

else
	newfile=$(ls $file | sed -r "s/\.\w*/.$ext/g")
	mv $file $newfile
fi


