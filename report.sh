#!/bin/bash
#Customized Automated reporting for the system. By Michael

emails=(michaelthomas.tx@gmail.com rob.ed.bell@gmail.com fanyumeng.mcf@gmail.com mahmoodim@vcu.edu)
rep=/home/common/Report.$(date +%s).doc

if [[ $EUID -ne 0 ]]; then
	echo "Insufficient priviedges. Remember to sudo."
	exit 1
fi

echo "Report Generated on $(date)" > $rep
echo "" >> $rep
entries=$(wc -l /home/common/logs/records.log | awk '{print $1}')
echo "Pulling $(($entries / 6)) User entries..." >> $rep
cat /home/common/logs/records.log >> $rep

echo "" >> $rep
echo "All sudo commands ran:" >> $rep
cat /var/log/secure | grep sudo >> $rep

echo "" >> $rep
echo "Mail records:" >> $rep
echo "WIP." >> $rep

echo "" >> $rep
echo "Ticket records:" >> $rep
echo "WIP." >> $rep

for i in "${emails[@]}"
do
	cat $rep | sendmail $i
done
