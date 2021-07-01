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
# SECTION 2: INSTALL NFS

echo "INSTALLING NFS"
# Cài đặt nfs
yum install nfs-utils -y

#########################################################################################
# SECTION 3: CONFIG

# Chuẩn bị thư mục chia sẻ:
# ví dụ thư mục chia sẻ trên NFS server là /share-data
mkdir /share-data

# tạo file để test
touch /share-date/data-on-server.test

# Thay đổi permission cho thư mục
chmod -R 755 /share-data
chown nfsnobody:nfsnobody /share-data

# Kích hoạt và chạy các dịch vụ cần thiết:

systemctl enable rpcbind
systemctl enable nfs-server
systemctl enable nfs-lock
systemctl enable nfs-idmap

systemctl start rpcbind
systemctl start nfs-server
systemctl start nfs-lock
systemctl start nfs-idmap

sleep 2

# Thiết lập quyền truy cập (client truy cập được từ một IP cụ thể của Client),
# cập nhật quyền này vào file /etc/exports,
# Ví dụ IP Client 172.16.10.107 có quyền truy cập:

cat >> "/etc/exports" <<END
/share-data    172.16.10.107(rw,sync,no_root_squash,no_all_squash)
END
systemctl restart nfs-server
sleep 2

# Mở cổng cho NFS qua firewall
firewall-cmd --permanent --zone=public --add-service=nfs
firewall-cmd --permanent --zone=public --add-service=mountd
firewall-cmd --permanent --zone=public --add-service=rpc-bind
firewall-cmd --reload

#########################################################################################
# SECTION 4: FINISH

echo "INSTALLING NFS FINISHED"

# check status nfs
systemctl status nfs-server

# export và kiểm tra cấu hình chia sẻ
exportfs -rav
exportfs -v
showmount -e