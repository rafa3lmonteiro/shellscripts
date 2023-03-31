#!/bin/bash

host=`hostname -i | cut -d " " -f 2`

master=`curl -s -XGET "http://$host:9200/_cat/master?v"|grep -vi 'ip' | awk '{print $3}'`


if [ $host == $master ]; then
	exit 0
else
	exit 1
fi