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

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs
RUN apt-get install -y build-essential
RUN ln -s /usr/bin/nodejs /usr/sbin/node
RUN  npm install -g create-react-app

EXPOSE 3001

CMD ["nginx", "-g", "daemon off;"]
