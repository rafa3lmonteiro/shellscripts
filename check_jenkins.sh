#!/bin/bash
#
# Check Jenkins status
#

output=`service jenkins status | awk '{print$5}'`

if [ "$output" == "running..." ]
then
	echo "0 check_jenkins - Jenkins UP"
	else
	 echo "2 check_jenkins - Jenkins DOWN"
fi