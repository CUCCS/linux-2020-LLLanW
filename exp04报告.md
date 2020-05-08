# 实验四：Shell脚本编程基础

## 实验目的：熟悉shell脚本编程方法

## 实验环境：Ubuntu18.04，VirtualBox，putty，travis  

## 任务一：用bash编写一个图片批处理脚本，实现以下功能（由于图片无法显示，此处运行结果均为复制粘贴的文字）

* **√支持命令行参数方式使用不同功能**

>lanw@lanw:~/workspace/shell-example\$ ./task1.sh -h
Usage:
-a                              compress JPEG picture
-b                              compression of the resolution
-c                              add watermark
-d                              rename pre-name
-e                              rename succeed-name
-f                              change format to jpg
-g                              filepath


* **√支持对jpeg格式图片进行图片质量压缩**

>lanw@lanw:~\/workspace/shell-example\$ ./task1.sh -g images/ -a 50
>finished
>lanw@lanw:~/workspace/shell-example$ ls images
>1.jpg          Boats24.png     after_compress_1.jpg  baboon512.png
>2.jpg          Sailboat24.png  after_compress_2.jpg  peppers2_512.png
>Barbara24.png  Zelda24.png     airplane512.png

* **√支持对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率**

>lanw@lanw:~/workspace/shell-example\$ ./task1.sh -g images/ -b 100
finished
lanw@lanw:~/workspace/shell-example$ ls images  
compress_resolution_2.jpg  
compress_resolution_Barbara24.png  
compress_resolution_Boats24.png  
compress_resolution_Sailboat24.png  
compress_resolution_Zelda24.png  
compress_resolution_after_compress_1.jpg  
compress_resolution_after_compress_2.jpg  
compress_resolution_airplane512.png  
compress_resolution_baboon512.png  
compress_resolution_peppers2_512.png  
compress_resolution_1.jpg  

* **√支持对图片批量添加自定义文本水印**

>lanw@lanw:~/workspace/shell-example\$ ./task1.sh -g images/ -c "lll"
finished
lanw@lanw:~/workspace/shell-example\$ ls -images
ls: invalid option -- 'e'
Try 'ls --help' for more information.
lanw@lanw:~/workspace/shell-example$ ls images
watermark_1.jpg
watermark_2.jpg
watermark_Barbara24.png
watermark_Boats24.png
watermark_Sailboat24.png
watermark_Zelda24.png
watermark_after_compress_1.jpg
watermark_after_compress_2.jpg
watermark_airplane512.png
watermark_baboon512.png

* **√支持批量重命名（统一添加文件名前缀或后缀，不影响原始文件扩展名**

     1.**添加前缀**  
    >lanw@lanw:~/workspace/shell-example\$ ./task1.sh -g images/ -e "lan"
finished
lanw@lanw:~/workspace/shell-example$ ls images
1lan.jpg                      compress_resolution_2lan.jpg                 watermark_1lan.jpg             watermark_compress_resolution_2lan.jpg
2lan.jpg                      compress_resolution_Barbara24lan.png

    2.**添加后缀**
    >lanw@lanw:~/workspace/shell-example\$ ./task1.sh -g images/ -d "cuc"
finished
lanw@lanw:~/workspace/shell-example$ ls images
cuc1lan.jpg                      cuccompress_resolution_2lan.jpg                 cucwatermark_1lan.jpg                      cucwatermark_compress_resolution_2lan.jpg
cuc2lan.jpg                      cuccompress_resolution_Barbara24lan.png         cucwatermark_2lan.jpg                      cucwatermark_compress_resolution_Barbara24lan.png
cucBarbara24lan.png              cuccompress_resolution_Boats24lan.png           cucwatermark_Barbara24lan.png  

* **√支持将png/svg图片统一转换为jpg格式图片**

>lanw@lanw:~/workspace/shell-example$ ./task1.sh -g images/ -f
finished
lanw@lanw:~/workspace/shell-example$ ls images
change_cuc1lan.jpg                                     change_cucwatermark_airplane512lan.jpg                           cuccompress_resolution_after_compress_1lan.jpg
change_cuc2lan.jpg                                     change_cucwatermark_baboon512lan.jpg                             cuccompress_resolution_after_compress_2lan.jpg
change_cucBarbara24lan.jpg                             change_cucwatermark_compress_resolution_1lan.jpg                 cuccompress_resolution_airplane512lan.png
change_cucBoats24lan.jpg                               change_cucwatermark_compress_resolution_2lan.jpg  

## 任务二：用bash编写一个文本批处理脚本，对以下附件分别进行批量处理完成相应的数据统计任务（结果见附件：task2实验结果.txt）

* [task2实验结果](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp04/task2%E5%AE%9E%E9%AA%8C%E7%BB%93%E6%9E%9C.txt)  


* **√统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比**

* **√统计不同场上位置的球员数量、百分比**

* **√名字最长的球员是谁？名字最短的球员是谁？**

* **√年龄最大的球员是谁？年龄最小的球员是谁？**

## 任务二：用bash编写一个文本批处理脚本，对以下附件分别进行批量处理完成相应的数据统计任务（结果见附件：task3实验结果.txt）

* [task3实验结果](https://github.com/CUCCS/linux-2020-LLLanW/blob/exp04/task3%E5%AE%9E%E9%AA%8C%E7%BB%93%E6%9E%9C.txt)  

* **√统计访问来源主机TOP 100和分别对应出现的总次数**

* **√统计访问来源主机TOP 100 IP和分别对应出现的总次数**

* **√统计最频繁被访问的URL TOP 100**

* **√分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数**

* **√给定URL输出TOP 100访问来源主机**

* **√年龄最大的球员是谁？年龄最小的球员是谁？**

## 遇到问题及注意事项

sudo apt get install imagemagick-6.q16直接安装！！！！不用传压缩包！！！  

问题1：文件开头写#!usr/bin/env bash为什么无法执行  
问题2：虚拟机中7z文件无法传到主机，导致水印图片无法查看  

## 参考资料

1.利用Travis CI+Github实现持续集成和自动部署：https://www.cnblogs.com/champyin/p/11621898.html  
2.师哥姐的实验报告：https://github.com/CUCCS/2015-linux-public-BiancaGuo  
https://github.com/CUCCS/2015-linux-public-JuliBeacon
