FROM        debian
MAINTAINER  Love Nyberg "love.nyberg@lovemusic.se"

# Update the package repository
RUN apt-get update; apt-get upgrade -y; apt-get install locales wget

# Configure timezone and locale
RUN echo "Europe/Stockholm" > /etc/timezone; dpkg-reconfigure -f noninteractive tzdata
RUN export LANGUAGE=en_US.UTF-8; export LANG=en_US.UTF-8; export LC_ALL=en_US.UTF-8; locale-gen en_US.UTF-8; DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

# Added dotdeb
RUN echo "deb http://packages.dotdeb.org wheezy all" >> /etc/apt/sources.list
RUN echo "deb-src http://packages.dotdeb.org wheezy all" >> /etc/apt/sources.list
RUN wget -q http://www.dotdeb.org/dotdeb.gpg -O- | apt-key add -

# Install base system
RUN DEBIAN_FRONTEND=noninteractive apt-get update; apt-get install -y curl nginx

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
RUN chmod 0755 /start.sh
CMD ["/start.sh"]