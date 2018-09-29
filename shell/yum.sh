#!/bin/bash

echo 'hello world'

rm -rf /etc/yum.repos.d/*

echo '正在配置yum'
echo "[rhel7]	
name=rhel7app
baseurl=ftp://172.25.0.250/rhel7
enabled=1
gpgcheck=0" > /etc/yum.repos.d/rhel7.repo	#配置yum
echo 'yum配置完成'

yum clean all &> /dev/null
echo 'yum仓库软件数量为：'
yum repolist |tail -1		#测试yum

yum -y install vsftpd &>/dev/null
systemctl restart vsftpd &>/dev/null
systemctl enable vsftpd &>/dev/null
echo 'vsftp已启动'
