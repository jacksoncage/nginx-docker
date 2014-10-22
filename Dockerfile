FROM        ubuntu:14.04.1
MAINTAINER  Love Nyberg "love.nyberg@lovemusic.se"
ENV REFRESHED_AT 2014-10-22

# Install applications
RUN apt-get update -qq && \
  apt-get upgrade -yqq && \
  apt-get -yqq install wget curl nginx && \
  apt-get -yqq clean

ADD 001-docker /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/001-docker /etc/nginx/sites-enabled/001-docker
ENV NGINX_RUN_USER www-data
ENV NGINX_RUN_GROUP www-data
ENV NGINX_LOG_DIR /var/log/nginx
ENV NGINX_BACKEND_IP 172.17.42.1
ENV NGINX_BACKEND_PORT 80
ENV NGINX_SERVER_NAME localhost

EXPOSE 80

ADD start.sh /start.sh
CMD ["/start.sh"]
