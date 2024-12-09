#!/bin/bash

file=$1

echo "Successful logins (IP addresses):"
cat $file | grep .*200 | awk '{print $5}' | sed 's/ip\=//g'
echo
echo
echo "Users with failed logins:"
cat $file | grep .*403 | awk '{print $4}'

