FROM        ubuntu
MAINTAINER  Love Nyberg "love.nyberg@lovemusic.se"
 
# Update apt sources
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list

# Update the package repository
RUN apt-get update; apt-get upgrade -y; apt-get install locales

# Configure timezone and locale
RUN echo "Europe/Stockholm" > /etc/timezone; dpkg-reconfigure -f noninteractive tzdata
RUN export LANGUAGE=en_US.UTF-8; export LANG=en_US.UTF-8; export LC_ALL=en_US.UTF-8; locale-gen en_US.UTF-8; DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

# Install base system
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget curl nginx

ADD 001-docker /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/001-docker /etc/nginx/sites-enabled/001-docker
ENV NGINX_RUN_USER www-data
ENV NGINX_RUN_GROUP www-data
ENV NGINX_LOG_DIR /var/log/nginx
ENV NGINX_BACKEND_IP 172.17.42.1
ENV NGINX_BACKEND_PORT 80
ENV NGINX_SERVER_NAME localhost

RUN service nginx restart
 
# Expose port 80
EXPOSE 80

ADD start /start
RUN chmod 0755 /start
CMD ["/start"]
