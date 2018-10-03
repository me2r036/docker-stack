#!/bin/bash
if [ -z $1 ];then
	sudo docker ps --format "table {{.ID}}\t{{.Names}}"  
else
   if [ -z $2 ];then
	sudo docker exec -it ${1} /bin/bash
   else
	sudo docker exec -it ${1} ${2}
   fi
fi
