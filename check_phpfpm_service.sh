#!/bin/bash
#
# Check php-fpm status
#

output=`systemctl status php-fpm | grep "Active" | awk '{print$3}'`

if [ "$output" == "(running)" ]
then
	echo "0 check_php-fpm - PHP-FPM UP"
	else
	 echo "2 check_php-fpm - PHP-FPM DOWN"
fi