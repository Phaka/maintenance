#!/bin/sh

el7() {
    # Cockpit
    yum install cockpit -y
    systemctl enable --now cockpit.socket
    firewall-cmd --permanent --zone=public --add-service=cockpit
    firewall-cmd --reload
    
    # Install Development Toolchains
    yum group install "Development Tools" -y
    yum install cmake -y
    yum install java-11-openjdk -y
    rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm
    yum install dotnet-sdk-6.0 -y
    
    # Patch
    yum check-update
    retVal=$?
    if [ $retVal -eq 100 ]; then 
        yum update -y
    else
        echo "System is up-to-date"
    fi
}

el9()  {
    # Cockpit
    dnf install cockpit -y
    systemctl start cockpit.socket
    systemctl enable cockpit.socket
    firewall-cmd --permanent --add-service=cockpit
    firewall-cmd --reload

    # Ensure toolchains are installed
    dnf group install "Development Tools" -y
    dnf install cmake -y
    dnf install java-11-openjdk -y
    dnf install dotnet-sdk-6.0 -y
    
    # Patch 
    dnf check-update -y
    retVal=$?
    if [ $retVal -eq 100 ]; then 
        dnf upgrade --allowerasing -y
    else
        echo "System is up-to-date"
    fi
}

el8()  {
    dnf --disablerepo '*' --enablerepo=extras swap centos-linux-repos centos-stream-repos -y
    el9
}

deb() {
  apt update -y
  apt install build-essential -y
  updates=$(apt list --upgradable | wc -l)
  if [ $updates -eq 0 ]; then 
    echo "System is up-to-date"
  else
    apt upgrade -y
  fi
}

OS="`uname`"
case $OS in
  'Linux')
    echo "Linux"
    OS='Linux'
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case $NAME in
        Debian*)
            deb
            ;;
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
