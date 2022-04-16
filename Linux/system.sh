#!/bin/bash
output=$HOME/my_script/sys_info.txt
ip=$(ip addr | grep inet | tail -2 | head -1)
execs=$(find /home -type f -perm 777 2> /dev/null)

if  [ ! -d $HOME/my_script ]
then
mkdir $HOME/my_script
fi

if [ -f $output ]
then rm $output
fi

echo "A quick scan takes place" >> $output
date >> $output
echo "Machine Type" >> $output
echo -e "MATCHTYPE \n" >> $output
echo $execs