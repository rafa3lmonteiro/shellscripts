#!/bin/bash
#
# Check mysql status
#

output=`service mysql status`
status=$?

echo "${status} mysql_status - ${output}"
