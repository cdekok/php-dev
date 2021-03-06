FROM ubuntu:13.10
MAINTAINER Chris de Kok <chris.de.kok@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

# Install
RUN apt-get -y install nano supervisor openssh-server nginx php5-fpm php5-curl php5-intl php5-gd php5-imagick php5-mcrypt php5-memcache php5-tidy

RUN mkdir -p /var/run/sshd
RUN mkdir -p /var/log/supervisor

# nginx site conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD ./nginx.conf /etc/nginx/sites-available/default

# PHP config
ADD ./php/php-fpm.ini /etc/php5/fpm/php.ini
ADD ./php/php-fpm.conf /etc/php5/fpm/php-fpm.conf
ADD ./php/www.conf /etc/php5/fpm/pool.d/www.conf

# Supervisor Config
ADD ./supervisord.conf /etc/supervisord.conf

#VOLUME        ["/www/", "/var/www"]
EXPOSE 22 80
CMD ["/usr/bin/supervisord"]
