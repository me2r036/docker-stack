FROM debian:stretch-slim

RUN apt-get update && apt-get install -y curl gnupg iputils-ping net-tools

RUN curl -L https://packagecloud.io/varnishcache/varnish5/gpgkey | apt-key add -
RUN apt-get install -y debian-archive-keyring apt-transport-https
RUN echo 'deb https://packagecloud.io/varnishcache/varnish5/ubuntu/ xenial main' > /etc/apt/sources.list.d/varnishcache_varnish5.list
RUN echo 'deb-src https://packagecloud.io/varnishcache/varnish5/ubuntu/ xenial  main' >> /etc/apt/sources.list.d/varnishcache_varnish5.list
RUN apt-get update &&  apt-get install -y varnish
RUn apt-get install -y iputils-ping net-tools

ADD entrypoint.sh /entrypoint.sh

ENV VCL_CONFIG      /etc/varnish/default.vcl
ENV CACHE_SIZE      64m
ENV VARNISHD_PARAMS -p default_ttl=3600 -p default_grace=3600 -p feature=+esi_ignore_https -p feature=+esi_disable_xml_check

RUN chmod 777 /entrypoint.sh

EXPOSE 80 6082

ENTRYPOINT ["/entrypoint.sh"]
