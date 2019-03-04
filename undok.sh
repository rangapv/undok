#! /bin/bash
li=$(uname -s)
li2="${li,,}"

u1=$(cat /etc/*-release | grep ubuntu)
f1=$(cat /etc/*-release | grep ID= | grep fedora)
c1=$(cat /etc/*-release | grep ID= | grep centos)
s1=$(cat /etc/*-release | grep suse)


if [ ! -z "$u1" ]
then 
	mi=$(lsb_release -cs)
	mi2="${mi,,}"
	ji=$(cat /etc/*-release | grep DISTRIB_ID | awk '{split($0,a,"=");print a[2]}')
	si=$(cat /etc/*-release | grep DISTRIB_CODENAME | awk '{split($0,a,"=");print a[2]}')
	ki="${ji,,}"

	if [ "$si" == "bionic" ]
	then
        sudo systemctl stop docker     
	sudo snap remove docker
	sudo pip uninstall -y docker-compose

        else
       
        sudo apt-get purge -y docker-engine docker docker.io docker-ce

        sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce
        echo "Do you want docker-compose to be uninstalled (y/n) "
        read dca
        if [ "$dca" == "y" ]
        then
         sudo pip uninstall -y docker-compose
        fi

        fi


fi

if [ ! -z "$f1" ]
then
        echo "It is Fedora $f1"
        ji=$(cat /etc/*-release | grep '^ID=' |awk '{split($0,a,"=");print a[2]}')
        ki="${ji,,}"
	cm1="dnf -y"
        sudo dnf -y remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

fi #end of fedora
