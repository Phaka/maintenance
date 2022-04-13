#!/bin/sh

USERNAME=$1
PASSWORD=$2

OS="`uname`"
case $OS in
  'Linux')
    if id -u "$user" >/dev/null 2>&1; then
      echo '$USERNAME exists'
    else
      useradd --create-home --user-group "$USERNAME"
    fi
    echo "$USERNAME:$PASSWORD" | chpasswd
    ;;
  'FreeBSD')
    echo "FreeBSD"
    OS='FreeBSD'
    ;;
  'NetBSD')
    echo "NetBSD"
    OS='NetBSD'
    ;;
  'OpenBSD')
    echo "OpenBSD"
    OS='OpenBSD'
    ;;
  'WindowsNT')
    echo "Windows"
    OS='Windows'
    ;;
  'Darwin') 
    echo "Darwin"
    OS='Darwin'
    ;;
  'SunOS')
    echo "Solaris"
    OS='Solaris'
    ;;
  'AIX') 
    echo "AIX"
    OS='AIX'
    ;;
  *) 
    echo "Unknown OS"
    OS='Unkown'
  ;;
esac


