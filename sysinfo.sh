#!/bin/sh

el7() {
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
}

el9()  {
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
}

el8()  {
    dnf --disablerepo '*' --enablerepo=extras swap centos-linux-repos centos-stream-repos
    el9
}

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
                el7
                ;;
            8)
                el8
                ;;
            9)
                el9              
                ;;
            *)
                echo "!!CentOS Linux Not Supported"
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
