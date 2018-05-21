#!/bin/bash
if [ $# != 2 ]; then
	echo "Usage: record <command> <task name>"
	echo "    Example: record 'yum install httpd' 'Installing Apache Server'"
	exit 1
fi

startTime=$(date)
if [ $(echo $1 | awk '{print $1}') == "yum" ]; then
	echo "Installing $(echo $1 | awk '{print $NF}') in 5 minutes. Please be sure to save your working data." | wall
	sleep 300
	echo "Installing $(echo $1 | awk '{print $NF}') now." | wall
fi
sudo $1
endTime=$(date)

log=/home/common/logs/records.log
echo "User: $USER" >> $log
echo "Task: $2" >> $log
echo "Services Installed / file configured: $(echo $1 | awk '{print $NF}')" >> $log
echo "Start time: $startTime" >> $log
echo "Finish time: $endTime" >> $log
echo "-" >> $log
