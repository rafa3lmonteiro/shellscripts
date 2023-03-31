#!/bin/bash
#
# Check Jenkins Slave status
#

output=`ps -ef |grep "bash -c" |grep "slave.jar" |awk '{print $1}'`

if [ $output == "jenkins" ]
then
	echo "0 check_jenkins_slave - Jenkins Slave UP"
	else
	 echo "2 check_jenkins_slave - Jenkins Slave DOWN"
fi