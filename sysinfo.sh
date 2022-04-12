#!/bin/sh

OS="`uname`"
case $OS in
  'Linux')
    echo "Linux"
    OS='Linux'
    if [ -f /etc/os-release ]; then
        OS=$NAME
        VER=$VERSION_ID
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
