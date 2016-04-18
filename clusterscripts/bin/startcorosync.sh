#!/bin/bash

while true
do
	if [[ -z $(ifconfig eth1 | grep inet[^6]) ]]
	then
		sleep 5
	else
		pcs cluster start
		exit 0
	fi
done
