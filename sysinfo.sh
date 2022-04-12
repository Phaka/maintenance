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
            5|6|7)
                yum group install "Development Tools" -y
                yum install cmake -y
                yum install java-11-openjdk -y
                yum check-update
                retVal=$?
                if [ $retVal -eq 100 ]; then 
                    yum update -y
                    shutdown -r +1
                else
                    echo "System is up-to-date"
                fi
                ;;
            8|9)
                dnf group install "Development Tools" -y
                dnf install cmake -y
                dnf install java-11-openjdk -y
                dnf check-update
                retVal=$?
                if [ $retVal -eq 100 ]; then 
                    dnf upgrade -y
                    shutdown -r +1
                else
                    echo "System is up-to-date"
                fi
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
