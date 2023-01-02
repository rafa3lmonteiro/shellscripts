#!/bin/bash
#
# Check Jenkins Porta 8080
#

output=`netstat -ntpl |grep java |grep 8080 |awk '{print $6}'`

if [ "$output" == "LISTEN" ]
then
	echo "0 check_jenkins_8080 - Porta 8080 Jenkins UP"
	else
	 echo "2 check_jenkins_8080 - Porta 8080 Jenkins DOWN"
fi