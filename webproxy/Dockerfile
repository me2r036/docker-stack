FROM debian:jessie

MAINTAINER NGINX Docker Maintainers "docker-maint@nginx.com"

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
  && echo "deb http://nginx.org/packages/debian/ jessie nginx" >> /etc/apt/sources.list \
  && apt-get update \
  && apt-get install --no-install-recommends --no-install-suggests -y \
            ca-certificates \
            nginx \
            gettext-base

#COPY certs /etc/pki/tls/certs
EXPOSE 80 443

ENV USING_VARNISH 'no'

ENV VARNISH_NODE0 'varnish0'
ENV VARNISH_NODE1 ''

ENV MAGE_NODE0 'mage2_node0'
ENV MAGE_NODE1 ''
ENV MAGE_NODE2 ''
ENV MAGE_NODE3 ''

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && echo `ls -al /entrypoint.sh`
ENTRYPOINT ["/entrypoint.sh"]
#CMD ["nginx", "-g", "daemon off;"]
