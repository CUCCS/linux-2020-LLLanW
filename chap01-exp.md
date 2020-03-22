# 实验一：无人值守Linux安装镜像制作

## 实验要求：无需操作、无需联网自动安装linux系统

## 实验环境：ubuntu18.04.4,VirtualBox,Putty

## 实验步骤

### 1.实验前配置

实验前，需将虚拟机配置双网卡，即添加host-only网络
![alt text](..\\ubuntu\host网络配置.PNG)
查询虚拟机的ip地址，建立putty连接
![alt text](..\\ubuntu\putty连接.PNG)

将iso文件上传到虚拟机中
![alt text](..\\ubuntu\psftp上传iso.PNG)

### 2.创建挂载iso文件的目录

>mkdir loopdir

### 3.挂载iso文件到该目录

>sudo mount -o loop ubuntu-18.04.4-server-amd64.iso loopdir

### 4.创建一个工作目录用于克隆光盘内容，并同步光盘内容到目标工作目录

>mkdir cd
>rsync -av loopdir/ cd

![alt text](..\\ubuntu\同步光盘内容到目录.PNG)

### 5.卸载iso镜像

>sudo umount loopdir

### 6.编辑Ubuntu安装引导界面增加一个新菜单项入口

>cd cd/
>vim isolinux/txt.cfg

### 并添加以下内容

>label autoinstall
  menu label ^Auto Install Ubuntu Server
  kernel /install/vmlinuz
  append  file=/cdrom/preseed/ubuntu-server-autoinstall.seed debian-installer/locale=en_US console-setup/layoutcode=us keyboard-configuration/layoutcode=us console-setup/ask_detect=false localechooser/translation/warn-light=true localechooser/translation/warn-severe=true initrd=/install/initrd.gz root=/dev/ram rw quiet

* 将该内容添加到首部！

* 注意！写完后记得强制保存退出：esc->:wq!(不是:x)

### 7.阅读并编辑定制Ubuntu官方提供的示例preseed.cfg，并将该文件保存到刚才创建的工作目录：~/cd/preseed/ubuntu-server-autoinstall.seed

定制过程：修改了用户名和密码，修改文件名为ubuntu-server-autoinstall.seed

上传：无法直接上传到目标目录，故先上传到home/lanw后在移动到/preseed中
![alt text](..\\ubuntu\记得cd。。移动到preseed.PNG)

### 8.重新生成md5sum.txt

* 此过程用sudo无法执行，需要登录到root用户

> sudo su -
> cd /home/cuc/cd && find . -type f -print0 | xargs -0 md5sum > md5sum.txt

封闭改动后的目录到.iso

>IMAGE=custom.iso
>BUILD=/home/cuc/cd/
>
>mkisofs -r -V "Custom Ubuntu Install CD" \
            -cache-inodes \
            -J -l -b isolinux/isolinux.bin \
            -c isolinux/boot.cat -no-emul-boot \
            -boot-load-size 4 -boot-info-table \
            -o \$IMAGE \$BUILD

* 注意：上述mkisofs语句为一个指令下的，不要分开打

* 如果上述语句出现错误，执行以下指令

>sudo apt-get update
>sudo apt-get install genisoimage

生成custom.iso
![alt text](..\\ubuntu\生成custom.PNG)

### 9.将custom.iso传送到本地

> \>psftp get custom.iso
![alt text](..\\ubuntu\传送custom.PNG)

## 实验结果

手动enter后，成功进行无人值守自动安装
![alt text](..\\ubuntu\成功.PNG)

## 实验问题

### 1.连接putty时总是time out（解决方法：将网络1改为桥接网卡模式）

### 2.遇到多个语句没有执行权限（解决方法：语句最前面加sudo）

### 3.isolinux/isolinux.cfg没有找到，故启动时需要手动enter一下（目前尚未解决）
