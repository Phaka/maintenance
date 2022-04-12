#!/bin/sh

OS="`uname`"
case $OS in
  'Linux')
    OS='Linux'
    if [ -f /etc/os-release ]; then
        OS=$NAME
        VER=$VERSION_ID
    fi
    ;;
  'FreeBSD')
    OS='FreeBSD'
    ;;
  'NetBSD')
    OS='NetBSD'
    ;;
  'OpenBSD')
    OS='OpenBSD'
    ;;
  'WindowsNT')
    OS='Windows'
    ;;
  'Darwin') 
    OS='Darwin'
    ;;
  'SunOS')
    OS='Solaris'
    ;;
  'AIX') 
    OS='AIX'
    ;;
  *) 
    OS='Unkown'
  ;;
esac

echo $OS