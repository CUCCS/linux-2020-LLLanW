# 实验六:Shell脚本编程进阶实验

## 实验环境

工作主机：ubuntu18.04，NAT+hostonly双网卡  
目标主机：Ubuntu18.04，NAT+hostonly双网卡  
windows10

## 实验过程

### 配置ssh远程免密登录

#### 目标主机配置

* 设置root密码  
    `sudo passwd`  

* 安装并启动ssh  
    `sudo apt-get install openssh-server`  
    `sudo systemctl start ssh`  

* 配置ssh文件  
    `sudo vim /etc/ssh/sshd_config`  
    修改以下内容,**注意将开头的#去掉**  
    `PermitRootLogin yes`  
    `PasswordAuthentication yes`  

* 重启ssh  
    `sudo systemctl restart ssh`  

#### 工作主机配置

* 生成密钥并传送给目标主机，建立连接，**注意生成密钥时前面不要加sudo，目标主机必须选root**  
    `ssh-keygen -f .ssh/pswd`  
    `ssh-copy-id -i ~/.ssh/pswd root@192.168.1.32`  
    `ssh root@192.168.1.32`  

* 实验结果  
![ssh](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp06/img/%E9%85%8D%E7%BD%AEssh%E8%BF%9C%E7%A8%8Broot%E7%99%BB%E5%BD%95.PNG)
&nbsp;

### FTP

#### 实验工具：vsftpd

#### ftp脚本文件

[vsftpd.sh](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp06/shell/vsftpd.sh)

#### ftp配置实验步骤

* 将脚本文件传送到目标主机并运行  
    `scp -i .ssh/pswd workspace/shell-example/vsftpd.sh root@192.168.1.32:vsftpf.sh`  
    `ssh -i root@192.168.1.32`  
    `bash vsftpd.sh`  

![ssh](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp06/img/upload_ftp.PNG)
&nbsp;

* 配置一个提供匿名访问的FTP服务器，匿名访问者可以访问1个目录且仅拥有该目录及其所有子目录的只读访问权限  
  * 匿名用户拥有且只拥有一个目录  
  ![ssh](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp06/img/anonymous_visit_server.PNG)
&nbsp;
  * 匿名用户对该目录只有只读权限  
  ![ssh](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp06/img/ftp_just_read.PNG)
&nbsp;

* 配置一个支持用户名和密码方式访问的账号，该账号继承匿名访问者所有权限，且拥有对另1个独立目录及其子目录完整读写（包括创建目录、修改文件、删除文件等）权限
  * 用户名密码登录  
  ![ssh](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp06/img/ftp_log_in.PNG)
&nbsp;
  * 删除文件、创建目录、修改文件  
  ![ssh](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp06/img/ftp_delete_rename_mkdir.PNG)
&nbsp;
  * FTP用户不能越权访问指定目录之外的任意其他目录和文件  
  ![ssh](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp06/img/cant_visit_other_upper_dir.PNG)
&nbsp;
* 匿名访问权限仅限白名单IP来源用户访问，禁止白名单IP以外的访问
  ![ssh](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp06/img/ftp_not_allow_other_IP_visit.PNG)
&nbsp;

### NFS

#### nfs脚本文件

[nfs_svr.sh](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp06/shell/nfs_svr.sh)

[nfs_clt.sh](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp06/shell/nfs_clt.sh)

#### nfs配置实验步骤

* 将server端脚本文件传送到目标主机并运行
    `scp -i .ssh/pswd workspace/shell-example/nfs_svr.sh root@192.168.1.32:nfs_svr.sh`  
    `ssh -i root@192.168.1.32`  
    `bash nfs_svr.sh`  

* 在目标主机通过进程查看nfs服务是否运行：`ps -aux|grep -v grep|grep nfs`  
![ssh](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp06/img/nfs_check_if_active.PNG)
&nbsp;
* 工作主机运行client端脚本：`bash nfs_clt.sh`

* 在1台Linux上配置NFS服务，另1台电脑上配置NFS客户端挂载2个权限不同的共享目录，分别对应只读访问和读写访问权限  
![ssh](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp06/img/check_dir.PNG)
&nbsp;

### DHCP

#### DHCP脚本文件

[dhcp.sh](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp06/shell/dhcp.sh)

#### DHCP实验过程

* 2台虚拟机使用Internal网络模式连接，其中一台虚拟机上配置DHCP服务，另一台服务器作为DHCP客户端，从该DHCP服务器获取网络地址配置  
  * 2台虚拟机使用Internal网络模式连接  
    ![ssh](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp06/img/dhcp_add_net.PNG)
&nbsp;
  * server配置  
  ![ssh](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp06/img/dhcp_check_server.PNG)
&nbsp;
  * client配置  
  ![ssh](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp06/img/dhcp_check_client.PNG)
&nbsp;

* 实验结果  
![ssh](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp06/img/dhcp_net_result.PNG)
&nbsp;

![ssh](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp06/img/dhcp_result.PNG)
&nbsp;

### DNS手动配置

#### DNS实验过程

* 目标主机安装Bind：`sudo apt-get install bind9`  

* 目标主机修改配置文件  
  * 修改options文件: `sudo vim /etc/bind/named.conf.options`
    >listen-on { 192.168.57.1; };
    allow-transfer { none; };
    forwarders {
        8.8.8.8;
        8.8.4.4;
    };
  
  * 修改named.conf.local文件：`sudo vim /etc/bind/named.conf.local`
    >zone "cuc.edu.cn" {
    type master;
    file "/etc/bind/db.cuc.edu.cn";
    };

  * 生成并编辑db.cuc.edu.cn文件：`sudo cp /etc/bind/db.local /etc/bind/db.cuc.edu.cn`
    >sudo vim /etc/bind/db.cuc.edu.cn
    >;
    >; BIND data file for local loopback interface
    >;
    >$TTL    604800
    >;@      IN      SOA     localhost. root.localhost.(
  >
  >    @       IN      SOA     cuc.edu.cn. admin.cuc.edu.cn. (
  >                                2         ; Serial
                           604800         ; Refresh
                            86400         ; Retry
                            2419200         ; Expire
                            604800 )       ; Negative Cache TTL
    ;
    ;@      IN      NS      localhost.
            IN      NS      ns.cuc.edu.cn.
    ns      IN      A       192.168.57.1
    wp.sec.cuc.edu.cn.      IN      A       192.168.57.1
    dvwa.sec.cuc.edu.cn.    IN      CNAME   wp.sec.cuc.edu.cn.
    @       IN      AAAA    ::1

* 目标主机重启Bind9
    `sudo service bind9 restart`  

* 工作主机安装resolvconf：`sudo apt update && sudo apt install resolvconf`  

* 工作主机修改配置文件：`sudo vim /etc/resolvconf/resolv.conf.d/head`
     >search cuc.edu.cn
    nameserver 192.168.57.1
    sudo resolvconf -u

* 实验结果  
![ssh](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp06/img/dns_ns_result.PNG)
&nbsp;

![ssh](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp06/img/dns_dig_result.PNG)
&nbsp;

### Samba

#### Samba脚本文件

[smb_svr.sh](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp06/shell/sm_svr.sh)

#### Samba实验过程

* 执行脚本文件：`sudo vim smb_svr.sh`  

* 在windows机器中进行操作  
  * 打开资源管理器，选择“此电脑”，添加一个网络位置  
  ![ssh](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp06/img/samba_ziyuanguanliqi.PNG)
&nbsp;
  * 输入共享文件夹路径  
  * 访问匿名目录，不用输入账号密码，且不可以创建文件夹  
  ![ssh](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp06/img/samba_anonymous_restrict.PNG)
&nbsp;
* 在Linux上连接Windows10上的服务器  
* Linux访问Windows的匿名共享目录  
![ssh](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp06/img/samba_anonymous_visit.PNG)
&nbsp;
* 下载整个目录  

## 遇到的问题

* ftpd 连接时报错421 service not available
    解决办法：修改/etc/hosts文件：`vsftpd: ALL`  

* nfs 无法建立共享
  `access denied by server while mounting`

## 参考资料

https://github.com/CUCCS/linux-2019-luyj/blob/Linux_exp0x06/Linux_exp0x06/Linux_exp0x06.md

ftp：https://security.appspot.com/vsftpd.html
ftp：https://ubuntu.com/server/docs/service-ftp

nfs：https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nfs-mount-on-ubuntu-18-04

dhcp：https://help.ubuntu.com/community/isc-dhcp-server
dns：https://ubuntu.com/server/docs/service-domain-name-service-dns

Samba：https://www.howtogeek.com/176471/how-to-share-files-between-windows-and-linux/