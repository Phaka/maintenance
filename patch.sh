#!/bin/sh

# Install some utils just in case its not installed
yum install yum-utils -y

# Check for updates. 
yum check-update
retVal=$?
if [ $retVal -eq 100 ]; then 
    yum update -y
    shutdown -r +1
else
    echo "System is up-to-date"
fi