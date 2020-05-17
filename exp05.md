# 实验五:Web服务器配置

## 实验环境

* Ubuntu18.04
* Nginx
* VreyNginx
* wordpress4.7
* dvwa

## 实验步骤

### 安装nginx

`sudo apt-get install nginx`
![installnginx](https://github.com/CUCCS/linux-2020-LLLanW/blob/chap05_exp/img/nginx.PNG.jpg)

### 安装并配置VeryNginx

#### 安装

`git clone https://github.com/alexazhou/VeryNginx.git`

* 注意！按照文档安装时**不要装libssl**，安装libssl-dev或libssl1.0-dev  
`sudo apt-get install libssl1.0-dev`
`sudo apt-get install libpcre3 libpcre3-dev`
* 注意！在执行`install.py install`前，**先安装zlib库**,否则无法成功

    `sudo apt-get install zlib1g.dev`
    `sudo python3 install.py install`
![installverynginx](https://github.com/CUCCS/linux-2020-LLLanW/blob/chap05_exp/img/install-verynginx.PNG)

#### 配置

>sudo vim /opt/verynginx/openresty/nginx/conf/nginx.conf
>user www-data
>···
>listen 192.168.56.101: 8080

#### 启动

    `/opt/verynginx/openresty/nginx/sbin/nginx`

若碰到`nginx: [emerg] bind() to 0.0.0.0:80 failed (98: Address already in use)`的情况，需找到使用端口80的进程并杀死
    `ps -A | grep nginx`
    成功进入Verynginx页面
![verynginx](https://github.com/CUCCS/linux-2020-LLLanW/blob/chap05_exp/img/%E7%99%BB%E5%BD%95verynginx.PNG)

### 配置LEMP堆栈

#### 安装并配置SQL

`sudo apt install mysql-server`
`sudo mysql_secure_installation #详情参见文档`

#### 安装并配置PHP

`sudo apt install php-fpm php-mysql`

>#修改nginx配置文件
>sudo vim /etc/nginx/sites-enabled/default
>location ~ \.php$ {
              include snippets/fastcgi-php.conf;
      #
      #       # With php-fpm (or other unix sockets):
              fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
      #       # With php-cgi (or other tcp sockets):
      #       fastcgi_pass 127.0.0.1:9000;
      }

### 安装并配置WordPress4.7

>#用psftp将压缩包传入虚拟机
> put C:\16227\Desktop\wordpress-4.7.zip
>#解压
>unzip wordpress-4.7.zip
>sudo mkdir /var/www/html/wp.sec.cuc.edu.cn
>sudo cp -r  WordPress-4.7 /var/www/html/wp.sec.cuc.edu.cn
>#修改配置文件
>sudo sed -i s/database_name_here/wp_db/ wp-config.php

### 连接wordpress和nginx

`#新建配置文件，设置端口8080和文件名:wp.sec.cuc.edu.cn`
`WP_DOMAIN = wp.sec.cuc.edu.cn`
`WP_PORT=8080`
`sudo tee /etc/nginx/sites-available/\${WP_DOMAIN} << EOF`
>server {
    listen localhost:\${WP_PORT};
    server_name \${WP_DOMAIN};
    root \${WP_PATH}/public;
    index index.php;
    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }
    location ~ \.php\$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php7.2-fpm.sock;
    }
}
EOF

#### 创建软链接

`sudo ln -s /etc/nginx/sites-available/${WP_DOMAIN} /etc/nginx/sites-enabled/`
`sudo rm /etc/nginx/sites-enabled/default`

#### 启动nginx

`systemctl start nginx`

### 安装并配置dvwa

>sudo git clone https://github.com/ethicalhack3r/DVWA
>mv DVWA /tmp/DVWA
>CREATE DATABASE dvwa DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
>GRANT ALL ON dvwa.* TO 'dvwauser'@'localhost' IDENTIFIED BY 'passdvwa';
>FLUSH PRIVILEGES;
>sudo systemctl restart mysql
>sudo cp config/config.inc.php.dist config/config.inc.php

#### 配置dvwa

`sudo vi /etc/php/7.2/fpm/php.ini`修改以下内容
`allow_url_include = Off -> On`

>sudo chmod 777 hackable/uploads/
>sudo chmod 777 external/phpids/0.6/lib/IDS/tmp/phpids_log.txt
>sudo chmod 777 config/

`sudo vi config/config.inc.php`修改以下内容
`# $_DVWA[ 'db_user' ] = 'dvwa';`

`sudo systemctl restart php7.2-fpm`

### 配置主机

>192.168.56.101  vn.sec.cuc.edu.cn
192.168.56.101  dvwa.sec.cuc.edu.cn
192.168.56.101  wp.sec.cuc.edu.cn

## 基本要求

* 在一台主机（虚拟机）上同时配置Nginx和VeryNginx  

![peizhi](https://github.com/CUCCS/linux-2020-LLLanW/blob/chap05_exp/img/fanxiangdaili.PNG)  

* 使用Wordpress搭建的站点对外提供访问的地址为： http://wp.sec.cuc.edu.cn  

* 使用Damn Vulnerable Web Application (DVWA)搭建的站点对外提供访问的地址为： http://dvwa.sec.cuc.edu.cn  

## 安全加固

* 使用IP地址方式均无法访问上述任意站点，并向访客展示自定义的友好错误提示信息页面-1

![renyizhandian](https://github.com/CUCCS/linux-2020-LLLanW/blob/chap05_exp/img/donotvist.PNG)  

* Damn Vulnerable Web Application (DVWA)只允许白名单上的访客来源IP，其他来源的IP访问均向访客展示自定义的友好错误提示信息页面-2

![baimingdan](https://github.com/CUCCS/linux-2020-LLLanW/blob/chap05_exp/img/baimingdan.PNG)  

* 在不升级Wordpress版本的情况下，通过定制VeryNginx的访问控制策略规则，热修复WordPress < 4.7.1 - Username Enumeration

![hotfix](https://github.com/CUCCS/linux-2020-LLLanW/blob/chap05_exp/img/hotfix.PNG)  

![hotfix](https://github.com/CUCCS/linux-2020-LLLanW/blob/chap05_exp/img/hotfixfilter.PNG)  

* 通过配置VeryNginx的Filter规则实现对Damn Vulnerable Web Application (DVWA)的SQL注入实验在低安全等级条件下进行防护

![sqlzhuru](https://github.com/CUCCS/linux-2020-LLLanW/blob/chap05_exp/img/protect.PNG)  

![sqlzhuru](https://github.com/CUCCS/linux-2020-LLLanW/blob/chap05_exp/img/protectfilter.PNG)  

## VeryNginx配置要求

* VeryNginx的Web管理页面仅允许白名单上的访客来源IP，其他来源的IP访问均向访客展示自定义的友好错误提示信息页面-3  

![baimingdan](https://github.com/CUCCS/linux-2020-LLLanW/blob/chap05_exp/img/buyunxu.PNG)  

* 通过定制VeryNginx的访问控制策略规则实现：
    1.限制DVWA站点的单IP访问速率为每秒请求数 < 50  
    2.限制Wordpress站点的单IP访问速率为每秒请求数 < 20  
    3.超过访问频率限制的请求直接返回自定义错误提示信息页面-4  

![sulv](https://github.com/CUCCS/linux-2020-LLLanW/blob/chap05_exp/img/sulv限制.PNG)

    4.禁止curl访问

![curl](https://github.com/CUCCS/linux-2020-LLLanW/blob/chap05_exp/img/curl.PNG)  

## 参考资料

https://github.com/CUCCS/linux-2019-jckling/blob/master/0x05/%E5%AE%9E%E9%AA%8C%E6%8A%A5%E5%91%8A.md
VeryNginx安装：https://github.com/alexazhou/VeryNginx
wordpress安装：https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-lemp-on-ubuntu-18-04