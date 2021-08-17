#!/bin/bash
Architecture=`uname -a`
CPU_pysical=`cat /proc/cpuinfo | grep processor | wc -l`
memory_usage=`free -k | sed -n 2p | awk '{print $7}'`
memory_total=`free -k | sed -n 2p | awk '{print $2}'`
memory_percentage=(`expr $memory_usage \* 100  / $memory_total`)
disk_usage=`df --total | grep total | awk '{print $4}'`
disk_total=`df --total | grep total | awk '{print $3}'`
disk_percentage=`df --total | grep total | awk '{print $5}'`
CPU_idle=`mpstat | sed -n 4p | awk '{print $13}'`
CPU_load_percentage=`echo "scale=3; 100 - $CPU_idle" | bc`
Last_reboot=`last reboot --time-format iso -n 10 | sed -n 2p | awk '{print $5}' | sed -e "s/T/ /" | sed -r "s/(................).*/\1/"` 
vCPU=`cat /proc/cpuinfo | grep "cpu cores" | awk '{print $4}'`
user=`who | wc -l`
connection_TCP=`netstat -a | grep "tcp" | wc -l`
ip_address=`ifconfig | grep "inet" -m1 | awk '{print $2}' `
MAC_address=`ifconfig | grep "ether" -m1 | awk '{print $2}'`
sudo_executedx2=`cat /var/log/sudo/sudolog | wc -l`
sudo_executed=`expr $sudo_executedx2 / 2`
lvscan_num=`lvscan | grep "ACTIVE" | wc -l`
if [lvscan_num==0];then
	LVM_use="no"
fi
	LVM_use="yes"

echo	"$lvscan_num"
echo	"	#Architecture: $Architecture"
echo	"	#CPU physical: $CPU_pysical"
echo	"	#vCPU: $vCPU"
echo	"	#Memory Usage: $memory_usage/$memory_total $meory_usage($memory_percentage%)"
echo	"	#Disk Usage: $disk_usage/$disk_total($disk_percentage)"
echo 	"	#CPU load: $CPU_load_percentage%"
echo	"	#Last boot: $Last_reboot"
echo	"	#LVM use: $LVM_use"
echo	"	#Conexions TCP:	$connection_TCP"
echo	"	#User log: $user"
echo	"	#Network: $ip_address($MAC_address)"
echo	"	#sudo: $sudo_executed"
