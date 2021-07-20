### Intro
    setup new disk iscsi
### Workflow
    1.Add new disk iscsi
      yum -y install iscsi-initiator-utils

      iscsiadm --mode discovery \
      --type sendtargets \
      --portal 172.20.10.110 \
      --discover 172.20.10.110:3260

      iscsiadm --mode node \
      --targetname iqn.2005-10.org.freenas.ctl:iscsi-linux \
      --login

    2.Check new disk in linux
      lsblk -f

    3.Partition new disk
      fdisk /dev/sdb
      ...
      #verify
      fdisk -l
      lsblk -f

    4.Format file system
      mkfs.xfs /dev/sdb1
      #verify
      fdisk -l
      lsblk -f

    5.Mount
      mkdir -p /mnt/iscsi-vol
      vi /etc/fstab
        UUID=62d15d52-fa9c-4d0c-ae71-0ff7ceb7b653 /mnt/iscsi-vol     xfs     defaults        0 0
      mount /mnt/iscsi-vol
      # verify
      lsblk -f
      mount -l | grep /mnt/iscsi-vol
      
    
    6.Unmount
      umount /mnt/data
      vi /etc/fstab
        delete UUID...

### Ref
    https://www.golinuxcloud.com/configure-iscsi-target-initiator-targetcli-rhel-centos-7/

