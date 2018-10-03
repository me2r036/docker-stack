#!/usr/bin/env bash

set -e

echo "import directors;" > /data/varnish/domains.vcl

echo "backend MAGE_NODE0 {" >> /data/varnish/domains.vcl
echo "  .host = \"${MAGE_NODE0}\";" >> /data/varnish/domains.vcl
echo "  .port = \"80\";" >> /data/varnish/domains.vcl
echo "  .first_byte_timeout = 600s;" >> /data/varnish/domains.vcl
echo "  .probe = {" >> /data/varnish/domains.vcl
echo "        .url = \"/health_check.php\";" >> /data/varnish/domains.vcl
echo "        .timeout = 2s;" >> /data/varnish/domains.vcl
echo "        .interval = 5s;" >> /data/varnish/domains.vcl
echo "        .window = 10;" >> /data/varnish/domains.vcl
echo "        .threshold = 5;" >> /data/varnish/domains.vcl
echo "   }" >> /data/varnish/domains.vcl
echo "}" >> /data/varnish/domains.vcl

if [ "$MAGE_NODE1" != "" ]; then
	echo "backend MAGE_NODE1{" >> /data/varnish/domains.vcl
	echo "  .host = \"${MAGE_NODE1}\";" >> /data/varnish/domains.vcl
	echo "  .port = \"80\";" >> /data/varnish/domains.vcl
	echo "  .first_byte_timeout = 600s;" >> /data/varnish/domains.vcl
	echo "  .probe = {" >> /data/varnish/domains.vcl
	echo "        .url = \"/health_check.php\";" >> /data/varnish/domains.vcl
	echo "        .timeout = 2s;" >> /data/varnish/domains.vcl
	echo "        .interval = 5s;" >> /data/varnish/domains.vcl
	echo "        .window = 10;" >> /data/varnish/domains.vcl
	echo "        .threshold = 5;" >> /data/varnish/domains.vcl
	echo "   }" >> /data/varnish/domains.vcl
	echo "}" >> /data/varnish/domains.vcl
fi
if [ "$MAGE_NODE2" != "" ]; then
        echo "backend MAGE_NODE2{" >> /data/varnish/domains.vcl
        echo "  .host = \"${MAGE_NODE2}\";" >> /data/varnish/domains.vcl
        echo "  .port = \"80\";" >> /data/varnish/domains.vcl
        echo "  .first_byte_timeout = 600s;" >> /data/varnish/domains.vcl
        echo "  .probe = {" >> /data/varnish/domains.vcl
        echo "        .url = \"/health_check.php\";" >> /data/varnish/domains.vcl
        echo "        .timeout = 2s;" >> /data/varnish/domains.vcl
        echo "        .interval = 5s;" >> /data/varnish/domains.vcl
        echo "        .window = 10;" >> /data/varnish/domains.vcl
        echo "        .threshold = 5;" >> /data/varnish/domains.vcl
        echo "   }" >> /data/varnish/domains.vcl
        echo "}" >> /data/varnish/domains.vcl
fi
if [ "$MAGE_NODE3" != "" ]; then
	echo "backend MAGE_NODE3 {" >> /data/varnish/domains.vcl
        echo "  .host = \"${MAGE_NODE3}\";" >> /data/varnish/domains.vcl
        echo "  .port = \"80\";" >> /data/varnish/domains.vcl
        echo "  .first_byte_timeout = 600s;" >> /data/varnish/domains.vcl
        echo "  .probe = {" >> /data/varnish/domains.vcl
        echo "        .url = \"/health_check.php\";" >> /data/varnish/domains.vcl
        echo "        .timeout = 2s;" >> /data/varnish/domains.vcl
        echo "        .interval = 5s;" >> /data/varnish/domains.vcl
        echo "        .window = 10;" >> /data/varnish/domains.vcl
        echo "        .threshold = 5;" >> /data/varnish/domains.vcl
        echo "   }" >> /data/varnish/domains.vcl
        echo "}" >> /data/varnish/domains.vcl
fi

echo "sub vcl_init {" >> /data/varnish/domains.vcl
echo "    new magento = directors.round_robin();" >> /data/varnish/domains.vcl
echo "    magento.add_backend(MAGE_NODE0);" >> /data/varnish/domains.vcl

if [ "$MAGE_NODE1" != "" ]; then
	echo "    magento.add_backend(MAGE_NODE1);" >> /data/varnish/domains.vcl
fi

if [ "$MAGE_NODE2" != "" ]; then
	echo "    magento.add_backend(MAGE_NODE2);" >> /data/varnish/domains.vcl
fi

if [ "$MAGE_NODE3" != "" ]; then
	echo "    magento.add_backend(MAGE_NODE3);" >> /data/varnish/domains.vcl
fi
echo "}" >> /data/varnish/domains.vcl

echo "sub vcl_recv {" >> /data/varnish/domains.vcl
echo "   set req.backend_hint = magento.backend();" >> /data/varnish/domains.vcl
echo "   set client.identity = req.http.user-agent;" >> /data/varnish/domains.vcl
echo "}" >> /data/varnish/domains.vcl

varnishd -F -a :80 -T :6082 -f ${VCL_CONFIG} -s malloc,${CACHE_SIZE} ${VARNISHD_PARAMS}
