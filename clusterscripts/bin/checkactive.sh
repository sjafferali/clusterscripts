#!/bin/bash

ACTIVE=$(crm_mon -1 | grep Masters | awk '{print$3}')
purple="\033[35;1m"
cyan="\033[1;36m"
green="\033[32m"
yellow="\033[0;33m"
bred="\033[1;31m"
blue="\033[0;34m"
defclr="\033[0m"


if [[ $(uname -n) == $ACTIVE  || $(hostname -s) == $ACTIVE ]]
then
	echo -e "$green You have logged on to the ACTIVE node. $defclr"
else
	echo -e "$bred You have logged on to the PASSIVE node. $defclr"
fi
echo
