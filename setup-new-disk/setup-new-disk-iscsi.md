### Intro
    setup new disk iscsi
### Workflow
    1.Add new disk iscsi
      yum -y install iscsi-initiator-utils
      systemctl start iscsid
      systemctl enable iscsid

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
        UUID=d1982789-cc22-4b8a-a9b8-612411b01526 /mnt/iscsi-vol     ext2     defaults        0 0
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

