#!/bin/bash


case $1 in
start)
  /usr/local/nginx/sbin/nginx
  echo "nginx is start";;
stop)
  /usr/local/nginx/sbin/nginx -s stop
  echo "nginx is stop";;
restart)
  /usr/local/nginx/sbin/nginx -s stop >/dev/null
  /usr/local/nginx/sbin/nginx
  echo "nginx is restart";;
status)
  netstat -ntulp|grep -q nginx
  if [ $? -eq 0 ];then
    echo "nginx server is running"
  else
    echo "nginx server not running"
  fi;;
*)
  echo "Please input start|stop|restar|status";;
esac
