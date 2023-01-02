#!/bin/bash
#
# Check HTTPD status
#

output=`service httpd status | awk '{print$5}'`

if [ "$output" == "running..." ]
then
	echo "0 check_httpd - HTTPD UP"
	else
	 echo "2 check_httpd - HTTPD DOWN"
fi