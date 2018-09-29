#!/bin/bash

#安装基础依赖包
yum -y install gcc make openssl-devel pcre-devel

ss -antulp | grep nginx > /dev/null
[ $? -eq 0 ] && /usr/local/nginx/sbin/nginx -s stop 

#定义变量
lnmp="lnmp.tar.gz"
nginxtar="lnmp/nginx-1.12.2.tar.gz"
nginxdir="nginx-1.12.2"
config=" --user=nginx --user=nginx --with-stream --with-http_ssl_module --with-http_stub_status_module"
nginxconf="/usr/local/nginx/conf/nginx.conf"

#解压lnmp整合包
tar -xf $lnmp
tar -xf $nginxtar

#源码包安装Nginx
useradd -s /sbin/nologin nginx
cd $nginxdir
./configure $config
make
make install

#安装Mariadb及其扩展依赖包
yum -y install mariadb mariadb-server mariadb-devel zlib-devel

#安装PHP及其扩展依赖包
yum -y install php php-mysql
cd /root/lnmp
yum -y install php-fpm-5.4.16-42.el7.x86_64.rpm

#配置
sed -i '65,71s/#//' $nginxconf
sed -i '70s/fastcgi_params/fastcgi.conf/' ${nginxconf}
sed -i '69d' ${nginxconf}

cd /root/lnmp
cp ./php_scripts/test.php /usr/local/nginx/html/

#启动服务
systemctl stop httpd
/usr/local/nginx/sbin/nginx
ss -antulp |grep 80
[ $? -eq 0 ] && echo "nginx is running" || echo "nginx is failed running"

systemctl start mariadb
ss -antulp |grep 3306
[ $? -eq 0 ] && echo "Mariadb is running" || echo "Mariadb is failed running"

systemctl start php-fpm
ss -antulp |grep 9000
[ $? -eq 0 ] && echo "PHP-fpm is running" || echo "PHP-fpm is failed running"



