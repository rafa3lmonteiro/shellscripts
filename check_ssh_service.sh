#!/bin/bash
#
# Check SSH status
#

output=`service sshd status | awk '{print$5}'`

if [ "$output" == "running..." ]
then
	echo "0 check_sshd - SSH UP"
	else
	 echo "2 check_sshd - SSH DOWN"
fi