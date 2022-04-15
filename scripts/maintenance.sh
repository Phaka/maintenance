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
  apt install -y build-essential openjdk-11-jdk 
  ARCH=`arch`
  echo $ARCH
  case $ARCH in
    i686|i386)    
        ;;
    x86_64)
        apt install -y dotnet-sdk-6.0              
        ;;      
    *)
        echo "!!Debian Linux Arch unknown"
        ;;
  esac
  
  apt upgrade -y
}

deb8() {
  apt-get install -y wget
  ARCH=`arch`
  echo $ARCH
  case $ARCH in
    i686|i386)    
        ;;
    x86_64)
          wget -O - https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
          mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
          wget https://packages.microsoft.com/config/debian/8/prod.list
          mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
          chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
          chown root:root /etc/apt/sources.list.d/microsoft-prod.list          
        ;;      
    *)
        echo "!!Debian Linux Arch unknown"
        ;;
  esac
  

  apt-get update -y
  apt-get install -y build-essential openjdk-11-jdk dotnet-sdk-2.1
  apt-get upgrade -y
}

deb9() {
  apt-get install -y wget
  ARCH=`arch`
  echo $ARCH
  case $ARCH in
    i686|i386)    
        ;;
    x86_64)
          wget -O - https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
          mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
          wget https://packages.microsoft.com/config/debian/9/prod.list
          mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
          chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
          chown root:root /etc/apt/sources.list.d/microsoft-prod.list          
        ;;      
    *)
        echo "!!Debian Linux Arch unknown"
        ;;
  esac
  deb
}

deb10() {
  apt-get install -y wget
  ARCH=`arch`
  echo $ARCH
  case $ARCH in
    i686|i386)    
        ;;
    x86_64)
        wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
        dpkg -i packages-microsoft-prod.deb
        rm packages-microsoft-prod.deb       
        ;;      
    *)
        echo "!!Debian Linux Arch unknown"
        ;;
  esac

  apt install -y apt-transport-https
  deb
}

deb11() {
  apt-get install -y wget
case $ARCH in
    i686|i386)    
        ;;
    x86_64)
        wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
        dpkg -i packages-microsoft-prod.deb
        rm packages-microsoft-prod.deb       
        ;;      
    *)
        echo "!!Debian Linux Arch unknown"
        ;;
  esac
  apt install -y apt-transport-https
  deb
}

freebsd() {
  pkg install -y cmake
  pkg install -y openjdk11
  freebsd-update fetch --not-running-from-cron
  freebsd-update updatesready --not-running-from-cron
  retVal=$?
  if [ $retVal -ne 2 ]; then
      freebsd-update install
  fi
}

netbsd() {
  # PKG_PATH="https://cdn.NetBSD.org/pub/pkgsrc/packages/NetBSD/$(uname -p)/$(uname -r | cut -d_ -f1)/All"
  # export PKG_PATH
  pkg_add -v pkgin
  pkgin update
  pkgin -y install sudo
  pkgin -y install patch 
  pkgin -y install pkgconf 
  pkgin -y install autoconf 
  pkgin -y install automake 
  pkgin -y install bash 
  pkgin -y install bzip2 
  pkgin -y install cmake 
  pkgin -y install git 
  pkgin -y install gmake 
  pkgin -y install m4 
  pkgin -y install meson 
  pkgin -y install nasm 
  pkgin -y install ninja-build 
  pkgin -y install python37 
  pkgin -y install gcc10 
  pkgin -y install openjdk11
  pkgin -y install sysupgrade

  # /usr/pkg/sbin/sysupgrade -o AUTOCLEAN=no -o ETCUPDATE=no auto 
}

openbsd() {
  pkg_add -v nano
  pkg_add -v gcc
  pkg_add -v git
  pkg_add -v jdk-11.0.7.10.2p0v0
  pkg_add -v autoconf 
  pkg_add -v automake 
  pkg_add -v bash 
  pkg_add -v bzip2 
  pkg_add -v gmake 
  pkg_add -v m4 
  pkg_add -v meson 
  pkg_add -v nasm 
  pkg_add -v ninja-build 
  pkg_add -v python37 
  pkg_add -v cmake
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
        case $VERSION_ID in
            8)
                deb8              
                ;;
            9)
                deb9              
                ;;
            10)
                deb10              
                ;;  
            11)
                deb11              
                ;;            
            *)
                echo "!!Debian Linux Not Supported"
                ;;
            esac
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
    freebsd
    ;;
  'NetBSD')
    echo "NetBSD"
    OS='NetBSD'
    netbsd
    ;;
  'OpenBSD')
    echo "OpenBSD"
    OS='OpenBSD'
    openbsd
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
