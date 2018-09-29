#!/bin/bash

get(){
cpu=$(uptime |awk 'END{print $10}')		#cpu十五分钟平均负载
eth_r=$(ifconfig eth0|awk '/RX p/{print $5}')	#收包
eth_t=$(ifconfig eth0|awk '/TX p/{print $5}')	#发包
memory=$(free |awk '/Mem:/{print $4}')		#内存余量
HDD=$(df |awk '$6=="/"{print $2}')		#硬盘（根目录）余量
usernum=$(cat /etc/passwd|wc -l)		#用户总数
user_OL=$(who |wc -l)				#在线用户数
ing_num=$(ps aux|wc -l)				#当前开启进程数量
app_num=$(rpm -qa|wc -l)			#已安装软件包数量
}

zhuan(){
	cpu_z=$(echo $cpu*100|bc |sed 's/\.00//')
	tmp=$[eth_r/1000]
	if $[ $tmp -eq 0 ];then
	  eth_r_z=

}

display(){
echo "CPU负载为：${cpu_z}%"
echo "网卡接收的数据包为：${eth_r}"
echo "网卡发送的数据包为：${eth_t}"
echo "内存余量:${memory}"
echo "根目录余量：${HDD}"
echo "用户总数为：${usernum}"
echo "在线用户数为：${user_OL}"
echo "当前开启的进程数为：${ing_num}"
echo "已安装的软件包数量为:${app_num}"
}

  clear
while :
do
  get
  zhuan
  display
  sleep 0.5
  clear
done

