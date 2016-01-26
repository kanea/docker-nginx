#
# Nginx on CentOS 6.7
#

FROM centos:centos6.7

MAINTAINER Adam Kane <adamckane@gmail.com>

RUN yum install -y wget

# Install
ADD config/nginx.repo /etc/yum.repos.d/nginx.repo
RUN yum install -y nginx

# Setup configs
RUN mkdir /srv/www
RUN rm /etc/nginx/conf.d/default.conf
COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/server.conf /etc/nginx/conf.d/server.conf
COPY config/index.html /srv/www/index.html

# Forward request logs to Docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
