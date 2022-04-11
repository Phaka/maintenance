#!/bin/sh

# Development Tools
yum group install "Development Tools" -y

# CMake
yum install cmake -y

# Java 11
yum install java-11-openjdk -y

# .NET Core 6
rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm
yum install dotnet-sdk-6.0 -y


