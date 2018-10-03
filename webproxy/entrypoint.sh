#!/usr/bin/env bash


set -e

echo "map \$host \$USING_VARNISH {">  /etc/nginx/constants.conf
echo "default '${USING_VARNISH}';" >> /etc/nginx/constants.conf
echo "}" >> /etc/nginx/constants.conf


echo "upstream webtier {" >> /etc/nginx/constants.conf

if [ "${USING_VARNISH}" = "yes" ]; then
	echo "server ${VARNISH_NODE0};" >> /etc/nginx/constants.conf
	if [ "$VARNISH_NODE1" != "" ]; then
		echo "server ${VARNISH_NODE1};" >> /etc/nginx/constants.conf
	fi
else
	echo "server ${MAGE_NODE0};" >> /etc/nginx/constants.conf
	if [ "$MAGE_NODE1" != "" ]; then
                echo "server ${MAGE_NODE1};" >> /etc/nginx/constants.conf
        fi
	if [ "$MAGE_NODE2" != "" ]; then
                echo "server ${MAGE_NODE2};" >> /etc/nginx/constants.conf
        fi
	if [ "$MAGE_NODE3" != "" ]; then
                echo "server ${MAGE_NODE3};" >> /etc/nginx/constants.conf
        fi
fi
echo "}" >> /etc/nginx/constants.conf

exec nginx -g "daemon off;"
