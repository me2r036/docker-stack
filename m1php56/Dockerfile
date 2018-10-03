FROM debian:jessie
MAINTAINER Tony Chen <yongcheng.chen@live.com>

#ENV DEBIAN_FRONTEND noninteractive
ENV NGINX_VERSION 1.10.3-1~jessie

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
  && echo "deb http://nginx.org/packages/debian/ jessie nginx" >> /etc/apt/sources.list \
  && apt-get update \
  && apt-get install --no-install-recommends --no-install-suggests -y \
            ca-certificates \
            nginx \
            gettext-base curl

RUN echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list
RUN curl  https://www.dotdeb.org/dotdeb.gpg > /tmp/dotdeb.gpg
RUN apt-key add /tmp/dotdeb.gpg
RUN apt-get update
RUN apt-get update

RUN apt-get install apt-transport-https ca-certificates

RUN curl https://packages.sury.org/php/apt.gpg  > /tmp/dotdeb.gpg
RUN apt-key add /tmp/dotdeb.gpg
RUN echo "deb https://packages.sury.org/php/ jessie main" > /etc/apt/sources.list.d/php.list
RUN apt-get update
RUN cat /etc/apt/sources.list.d/php.list

RUN apt-get -qq install php5.6 php5.6-fpm php5.6-mcrypt php5.6-curl php5.6-gd php5.6-mysql php5.6-xml php5.6-mbstring php5.6-zip vim git

RUN sed -i -e 's/www-data/root/g' /etc/php/5.6/fpm/pool.d/www.conf \
 && sed -i -e "s/;clear_env = no/clear_env = no/g" /etc/php/5.6/fpm/pool.d/www.conf \
  && sed -i -e "s/DAEMON_ARGS=\"/DAEMON_ARGS=\"--allow-to-run-as-root /g" /etc/init.d/php5.6-fpm \
  && sed -i -e "s/user  nginx/user root/g" /etc/nginx/nginx.conf

RUN sed -i -e 's/128M/2048M/g' /etc/php/5.6/fpm/php.ini

RUN echo "alias ll='ls -l'" >> /root/.bashrc \
  && echo "alias vim='vi'" >> /root/.bashrc

#RUN apt-get install -y cron

EXPOSE 80 443

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && echo `ls -al /entrypoint.sh`
ENTRYPOINT ["/entrypoint.sh"]

#CMD ["nginx", "-g", "daemon off;"]
