#!/bin/bash
#
# Check nginx status
#

output=`systemctl status nginx | grep "Active" | awk '{print$3}'`

if [ "$output" == "(running)" ]
then
	echo "0 check_nginx - Nginx UP"
	else
	 echo "2 check_nginx - Nginx DOWN"
fi
