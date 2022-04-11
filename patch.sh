#!/bin/sh

yum check-update
retVal=$?
if [ $retVal -eq 100 ]; then
    yum update
else
    echo "System is up-to-date"
fi