#!/bin/bash
#
# Check SSH status
#

output=`systemctl status sshd | grep "Active" | awk '{print$3}'`

if [ "$output" == "(running)" ]
then
	echo "0 check_sshd - SSH UP"
	else
	 echo "2 check_sshd - SSH  DOWN"
fi