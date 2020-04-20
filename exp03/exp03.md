# 实验三：systemd自学  

## 实验要求：练习systemd相关内容  

## 实验环境：Ubuntu 18.04，asciinema，putty

## 自学视频

[命令篇：第三章](https://asciinema.org/a/phldxT4hkiZP56oIIT9LOJsj1)  

[命令篇：第四章](https://asciinema.org/a/nUfZ14ORVsDeWwLBPf6Jzi6mx)  

[命令篇：第五-七章](https://asciinema.org/a/WbQOd5FvibZYpAjqCA2Kz7jem)  

[实战篇](https://asciinema.org/a/tcvsZHBpuvmJ5WfSqbjZ63PL0)  

## 自查清单  

* **如何添加一个用户并使其具备sudo执行程序的权限？**  
    >add user *username* //添加一个用户
    >sudo usermod -aG sudo *username*  //赋予用户sudo权限（加入到sudo组）

&nbsp;

* **如何将一个用户添加到一个用户组？**  

    >sudo *usermod* -aG *groupname* *username*

&nbsp;

* **如何查看当前系统的分区表和文件系统详细信息？**  

    >fdisk -l 或者 df -T  

&nbsp;

* **如何实现开机自动挂载Virtualbox的共享目录分区？**  

    步骤：  
    1.安装增强功能  
    2.**在虚拟机关机时**设置共享文件夹:设置-共享文件夹-新增共享文件夹  
    3.输入以下代码：
    >mkdir /mnt/share //建立目录
    >sudo mount -t vboxsf exp03 /mnt/share //实现挂载  

    4.在*/etc/rc.local*中加入以下代码：  
    >mount -t vboxsf linux /mnt/share //实现开机自启动  

&nbsp;

* **基于LVM（逻辑分卷管理）的分区如何实现动态扩容和缩减容量？**  

    1.扩容
    >lvextend -l [+]Number[PERCENT]/-L [+]Size[m|UNIT] position_args

    2.缩减  
    >lvreduce -L|--size [-]Size[m|UNIT] LV

&nbsp;

* **如何通过systemd设置实现在网络连通时运行一个指定脚本，在网络断开时运行另一个脚本？**  
    >systemctl cat networking.service //查看配置文件  

    将[Service]中添加以下内容  
    >ExecStartPre = /脚本1位置  
    >ExecStopPost = /脚本2位置
  
&nbsp;

* **如何通过systemd设置实现一个脚本在任何情况下被杀死之后会立即重新启动？实现杀不死？**  

    修改该脚本[service]的*Unit*  
    >Restart=always  
