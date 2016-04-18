#!/bin/bash

source /opt/instance-setup/config

if [[ ! -z $EIP ]]
then
	if [[ -z $(aws ec2 describe-instances --instance-ids $INSTANCE_ID --output text | grep $EIP) ]]
	then
		/usr/bin/aws ec2 associate-address --instance-id $INSTANCE_ID --allocation-id $EIP
	fi
fi

if [[ ! -z $INTERFACE_ID ]]
then
	if [[ -z $(aws ec2 describe-instances --instance-ids $INSTANCE_ID --output text | grep $INTERFACE_ID) ]]
	then
		ATTACHMENT_ID=$(/usr/bin/aws ec2 describe-network-interfaces --network-interface-ids $INTERFACE_ID --output text | awk '/ATTACHMENT/ {print$3}')
		if [[ ! -z $ATTACHMENT_ID ]]
		then
			/usr/bin/aws ec2 detach-network-interface --attachment-id $ATTACHMENT_ID
		fi
		/usr/bin/aws ec2 attach-network-interface --instance-id $INSTANCE_ID --network-interface-id $INTERFACE_ID --device-index 1
	fi
fi

if [[ ! -z $EBS ]]
then
        if [[ -z $(aws ec2 describe-instances --instance-ids $INSTANCE_ID --output text | grep $EBS) ]]
        then
		/usr/bin/aws ec2 detach-volume --volume-id $EBS
		/usr/bin/aws ec2 attach-volume --instance-id $INSTANCE_ID --volume-id $EBS --device /dev/sdb
	fi
fi
