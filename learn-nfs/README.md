# learn-nfs
### Mục đích/ứng dụng
    - xây dụng server nfs

### ứng dụng (use case)
    - dùng nfs tạo PersisternVolume cho k8s.
      ref: https://xuanthulab.net/su-dung-persistentvolume-nfs-tren-kubernetes.html
    - dùng nfs giống như file server.
    - dùng NFS tạo ổ đĩa chia sẻ chạy các dịch vụ trên Docker Swarm.

### Triển khai NFS
1. Step : Chuẩn bị VM bằng vagrant

2. Step : Tạo shell script để triển khai server và client

3. Step : Testing

4. Step : Enjoy !!!

### Ref
    https://xuanthulab.net/cai-dat-va-su-dung-nfs-server-tren-centos-de-chia-se-o-dia.html
    https://blogd.net/linux/thiet-lap-may-chu-nfs-tren-linux/   
    https://linuxize.com/post/how-to-mount-an-nfs-share-in-linux/
    

### Notes
    - image generic/centos7 bị error with nfs, không mount được tự động trong /etc/fstab
    - research /etc/fstab
        -https://geek-university.com/linux/etc-fstab-file/
        -https://manthang.wordpress.com/2010/11/27/   cau-hinh-file-etc-fstab-de-quan-ly-viec-mount-thiet-bi-trong-linux/
