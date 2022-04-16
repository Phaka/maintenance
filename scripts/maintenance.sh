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
  apt install -y build-essential git cmake openjdk-11-jdk 
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
  pkg install -y git
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

openbsd_pkg_add() {
  echo "Installing \"$1\""
  pkg_add -v $1
  echo "---"
}

openbsd_6_8() {
  openbsd_pkg_add nano
  openbsd_pkg_add gcc
  openbsd_pkg_add git
  openbsd_pkg_add automake-1.4.6p5 
  openbsd_pkg_add bash 
  openbsd_pkg_add bzip2 
  openbsd_pkg_add gmake 
  openbsd_pkg_add m4 
  openbsd_pkg_add meson 
  openbsd_pkg_add nasm 
  openbsd_pkg_add ninja-build 
  openbsd_pkg_add python-3.8.6p1 
  openbsd_pkg_add cmake
  openbsd_pkg_add jdk-11.0.8.10.1v0.tgz
  openbsd_pkg_add autoconf-2.69p3.tgz
}

openbsd() {
  VERSION=`uname -r`
  case $VERSION in
    6.8)
        openbsd_6_8              
        ;;
    *)
        echo "!!OpenBSD $VERSION Not Supported"
        ;;
    esac
}

brew_install() {
    echo "\nInstalling $1"
    if brew list $1 &>/dev/null; then
        echo "${1} is already installed"
    else
        brew install $1 && echo "$1 is installed"
    fi
}


darwin_12() {
  sw_vers
  brew install -y cmake git
}

darwin() {
  export NONINTERACTIVE=1
  sudo -H -u phaka /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo $(brew --prefix)
  echo $(groups $(whoami))
  dseditgroup -o edit -a $(whoami) -t user admin
  chgrp -R admin $(brew --prefix) 
  chmod -R g+rwX $(brew --prefix)
  ls -lah $(brew --prefix)
  VERSION=`sw_vers -productVersion`
  case $VERSION in
    12*)
        darwin_12              
        ;;
    11*)
        echo "!!macOS $VERSION Not Supported"
        ;;
    esac
}

solaris() {
  pkg install cmake
  pkg install openjdk11
  pkg install git
}

echo "---------------------------------------------------------------------"
uname -a
echo "---------------------------------------------------------------------"
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
    solaris
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
