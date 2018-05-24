#!/bin/bash
if [[ $EUID -ne 0 ]]; then
	echo "Cannot run as current user."
	exit 1
fi

echo "Scheduled system patch starting in 10 minutes. Please save your data." | wall
sleep 600
echo "System patch beginning." | wall

mkdir /home/common
mkdir /home/common/scripts
mkdir /home/common/logs
cp record.sh /home/common/scripts
cp report.sh /home/common/scripts
echo "0 12 * * * root /home/common/scripts/report.sh" >> /etc/crontab

yum install -y httpd mariadb mariadb-server php-mysql wget unzip zip
systemctl enable httpd
systemctl start httpd
systemctl enable mariadb
systemctl start mariadb
mysql_secure_installation

echo "Done. Make sure to open ports on AWS Console."

