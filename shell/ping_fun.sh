#!/bin/bash

num="176.204.13"

pingfun(){
	ping -c 2 -i 0.2 -w 1 $num.$i >/dev/null
	if [ $? -eq 0 ];then
	    echo "$num.$1 is up"
	else
	    echo "$num.$1 is down"
	fi
}



for i in {1..254}
do
    pingfun $i &
    let i++

done

wait
