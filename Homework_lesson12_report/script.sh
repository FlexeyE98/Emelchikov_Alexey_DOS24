#!/bin/bash

file=$1

cat $file | grep ".*200"
cat $file | grep ".*403" | sort -u | uniq





