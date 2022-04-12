#!/bin/sh

OS="`uname`"
case $OS in
  'Linux')
    echo "Linux"
    OS='Linux'
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case $(NAME | tr '[:upper:]' '[:lower:]') in
        'centos')
            echo "CentOS"
            ;;
        *) 
            echo "Unknown Linux Distro: $NAME"
            ;;
        esac
        echo $NAME
        echo $VERSION_ID
    fi
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
