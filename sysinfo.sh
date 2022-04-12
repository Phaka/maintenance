#!/bin/sh

OS="`uname`"
case $OS in
  'Linux')
    echo "Linux"
    OS='Linux'
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case $NAME in
        CentOS*)
            case $VERSION_ID in
            6)
                echo "!!CentOS 6"
                ;;
            7)
                echo "!!CentOS 7"
                ;;
            8)
                echo "!!CentOS 8"
                ;;
            9)
                echo "!!CentOS 9"
                ;;
            esac
            ;;
        *) 
            echo "Unknown Linux Distro: $NAME"
            ;;
        esac
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
