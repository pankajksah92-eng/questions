Shell script

#!/bin/bash
# Author: Pankaj Kumar
# Date: 27/03/2026
# Description: This script will only pull error message from /var/log/messages
# Modified: 27/03/2026
 
grep -i error /var/log/messages
======================================================================================
$*  -->>  all argument as single string  like "name is pankaj"
$@ --> all argument as seperate string "name" "is" "pankaj"
========================================================================================
-eq
-lt
-gt
-le
-ge
-ne
==================================================================================
if [          ]


fi
====================================================================================
count  = 0
while [           ]
do

done
=======================================================================================
for name in $names
do


done
==================================================================================
func_name Hello ( ) {

}

Hello --> for calling
=====================================================================================
#!/bin/bash
# Author: Pankaj Kumar
# Date: 27/03/2026
# Description: Format the output of admin commands
# Modified: 27/03/2026

date | awk '{print $1}'
uptime | awk '{print $3}'
df -h | grep root

=============================================================================================

#!/bin/bash
# Author: Pankaj Kumar
# Date: 27/03/2026
# Description: This script will ping a remote host and notify and don't display ping output on screen
# Modified: 27/03/2026

host="127.0.0.1"
ping -c1 $host &> /dev/null
if [ $? -eq 0 ]
then
echo $host is ok
else
echo $host is not ok
fi

========================================================================================
#ping check using function

#!/bin/bash

check_host () {
    ping -c 1 $1 > /dev/null
    if [ $? -eq 0 ]
    then
        echo "$1 is reachable"
    else
        echo "$1 is not reachable"
    fi
}

check_host 127.0.0.1
check_host 192.168.1.5

==========================================================================================
#check uptime of servrs

#!/bin/bash

for server in $(cat servers.txt)
do
    echo "Checking uptime for $server"
    ssh $server "uptime"
done

or

#!/bin/bash

while read server
do
    echo "Checking uptime for $server"
    ssh $server "uptime"
    echo "-----------------------"
done < inventory.txt
===========================================================================================
#!/bin/bash
# Author: Pankaj Kumar
# Date: 27/03/2026
# Description: This script will ping multi remote host and notify
# Modified: 27/03/2026

host="/home/pankaj/shell-script/inventory"
for ip in $(cat $host)
do
ping -c1 $ip &> /dev/null
if [ $? -eq 0 ]
then
echo $ip is ok
else
echo $ip is not ok
fi
done

================================================================================================

#grep CRON /var/log/syslog
#* * * * * /home/pankaj/shell-script/ping-test >> /home/pankaj/shell-script/ping-output 2>&1
#crontab -e
#crontab -l
#crontab -r
# Description: This script will ping multi remote host and notify using cron job

35 01 * * * /home/pankaj/shell-script/ping-test > /home/pankaj/shell-script/ping-output

===============================================================================================

Create files with older timestamp
touch -d "Thu, 1 March 2018 12:30:00"  file1

Find and delete files older than 90 days
#find /path-to-dir -mtime +90 -exec ls -l {} \;
find /home/pankaj/shell-script/ -mtime +90 -exec rm {} \;

Find and rename old files
find home/pankaj/shell-script/ -mtime +90 -exec mv {} {}.old \;

================================================================================================
#!/bin/bash

# Create backup
tar cvf /tmp/backup.tar /etc /var
# Compress backup
gzip backup.tar
#Check backup status and transfer

find backup.tar.gz -mtime -1 -type f -print &> /dev/null
if [ $? -eq 0 ]
then
echo Backup was created
echo
echo Archiving backup
scp /tmp/backup.tar.gz root@192.168.1.x:/path
else
echo Backup failed
fi

==============================================================================================

Assign write permissions to files
#!/bin/bash

for i in imran*     # name all start with imran
do
	echo Assigning write permissions to $i
	chmod a+w $i
    sleep 1
done

===============================================================================================

1 - Rename all *.txt files extension to none

#!/bin/bash
for filename in *.txt
do
	mv $filename ${filename%.txt}.none      #% is wild card
done


2 - Check to see if files exist

#!/bin/bash
# List of files you are curious about

FILES="/etc/passwd  /etc/group /etc/shadow  /etc/nsswitch.conf /etc/sshd_ssh_config /etc/fake"

echo
for file in $FILES
do


	if [ ! -e "$file" ]       # Check if file exists , not equel to files
	then


	echo $file = does not exist
	echo
	fi
done

==================================================================================================

#pankaj@pankaj-Inspiron-N5010:~/shell-script$ ps -ef | grep "sleep 600" | grep -v grep | awk '{print$2}' | xargs -I{} echo {}
#14514

sleep 600

#!/bin/bash
ps -ef | grep "sleep 600" | grep -v grep | awk '{print$2}' | xargs -I{} kill {}

echo All sleeping processes are killed

=========================================================================================

Status on Total Number of Files (Send alert if files are less than 20)

# First create 20 files

touch file{1..20}.txt
---------------------------------------------------

Now create a script:

#!/bin/bash

a=`ls -l file* | wc -l`

	if [ $a -eq 20 ]
	then
	echo Yes there are $a files
	else
	echo Files are less than 20
	fi

===============================================================================================

We have 5 servers ip in inventory file

Write scripts to check the uptime of these servers

#!/bin/bash

for ip in $(cat /home/pankaj/shell-script/inventory)
do
    echo "Checking uptime for $ip"

    ssh $ip "uptime" 2>/dev/null    #run uptime and error will be send to dev null

    if [ $? -ne 0 ]
    then
        echo "$ip is not reachable"
    fi

    echo "-----------------------"
done
========================================================================

Check disk space greater than 50


#!/bin/bash
a=`df -h | egrep -v "tmpfs|devtmpfs" | tail -n+2 | awk '{print $5}' | cut -d'%' -f1`

for i in $a
do
        if [ $i -ge 50 ]
        then
        echo Check disk space $i `df -h | grep $i`
        fi
done