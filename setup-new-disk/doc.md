### Intro
    setup new disk iscsi on VM
### Workflow
    1.Add new disk to VM

    2.Check new disk in linux
      lsblk

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
      mkdir -p /mnt/data
      vi /etc/fstab
        UUID=62d15d52-fa9c-4d0c-ae71-0ff7ceb7b653 /mnt/data     xfs     defaults        0 0
      mount /mnt/data
      # verify
      mount -l | grep /mnt/data
      lsblk -f
    
    6.Unmount
      umount /mnt/data
      vi /etc/fstab
        delete UUID...

