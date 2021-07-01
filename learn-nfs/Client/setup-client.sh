#!/bin/bash

##########################################################################################
# SECTION 1: PREPARE

# update system
sudo -i
sleep 1
yum clean all
yum -y update
sleep 1

# config timezone
timedatectl set-timezone Asia/Ho_Chi_Minh

# disable SELINUX
setenforce 0 
sed -i 's/enforcing/disabled/g' /etc/selinux/config

# disable firewall
# systemctl stop firewalld
# systemctl disable firewalld

# config hostname
# hostnamectl set-hostname node1

# config file host
#cat >> "/etc/hosts" <<END
#172.16.10.100 node1
#172.16.10.101 node2
#172.16.10.102 node3 
#END

# config network, config in vagrantfile in dev

##########################################################################################
# SECTION 2: INSTALL NFS CLIENT

echo "INSTALLING NFS CLIENT"
# Cài đặt nfs
yum install nfs-utils -y

#########################################################################################
# SECTION 3: CONFIG

# Gán (mount) ổ đĩa NFS Server vào máy Client
# Thiết lập để thư mục /share-data từ NFS Server có IP 172.16.10.106,
# sẽ gắn vào /mnt/nfs/share-data của máy Client

mkdir -p /mnt/nfs/share-data
#mount -t nfs 172.16.10.106:/share-data /mnt/nfs/share-data/

mount tự động sau khi boot
cat >> "/etc/fstab" <<END
172.16.10.106:/share-data /mnt/nfs/share-data nfs defaults 0 0
END

mount /mnt/nfs/share-data

#########################################################################################
# SECTION 4: FINISH

echo "INSTALLING NFS CLIENT FINISHED"

# check 
echo "check: ls /mnt/nfs/share-data/"
ls /mnt/nfs/share-data/