#!/bin/bash
sudo apt-get update
echo "----------package update done---------------------"
# Below code to check whether apache2 installed or not, if not then install it.
pkgs='apache2'
if ! dpkg -s $pkgs >/dev/null 2>&1 
then
        sudo apt-get install $pkgs -y
fi

echo "-----------apache2 check done--------------------"
#Below code will check apache2 service is enabled or not, if not then enable it.
apache2_check="$(systemctl status apache2.service | grep Active | awk {'print $3'})"

if [ "${apache2_check}" = "(dead)" ] 
then
        systemctl enable apache2.service
        echo "service enabled"
fi

#Below code will check whether apache2 is running or not, if not then start the service.
ServiceStatus="$(systemctl is-active apache2.service)"

if [ "${ServiceStatus}" = "active" ] 
then
	echo "Already apache2 running" 
else
        sudo systemctl start apache2
        echo "Service started"
fi

echo "-----------apache2 service status check done, started if its in stoped--------------------"
sudo systemctl status $pkgs  
echo "--------------status as after started---------------------------"
