#!/bin/bash

fileout=$1
folder=$2
ext=$3

find $folder -type f | while read file
do
	echo $file >> $fileout
done





