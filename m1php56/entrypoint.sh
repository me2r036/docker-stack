#!/usr/bin/env bash
#if [ -f /var/www/prepare.sh ];then
#  echo 'please hold on, preparing your ENV'
#  /bin/bash /var/www/prepare.sh
#fi

echo 'hostname:' `hostname` ' started'
echo `ip addr | grep global`

service php5.6-fpm start
cd /var/www/html
#php bin/magento cron:install
#service cron start
exec nginx -g "daemon off;"
