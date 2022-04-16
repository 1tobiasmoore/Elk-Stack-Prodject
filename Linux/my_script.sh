#!/bin/bash
name="Jake"
echo "Hello $name."
echo -e "\nThis is my script. \n"
echo -e "The files in $PWD are: \n$(ls)"
echo -e "\nCopying the passwd file to your current directory.\n"
cp /etc/passwd $PWD
echo -e "\n"
echo -e "The files in $PWD are now: \n$(ls)"