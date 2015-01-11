#!/bin/bash

# Using environment variables to set nginx configuration
[ -z "${NGINX_BACKEND_IP}" ] && echo "\$NGINX_BACKEND_IP is not set" || sed -i "s/NGINX_BACKEND_IP/${NGINX_BACKEND_IP}/" /etc/nginx/sites-enabled/001-docker
[ -z "${NGINX_BACKEND_PORT}" ] && echo "\$NGINX_BACKEND_PORT is not set" || sed -i "s/NGINX_BACKEND_PORT/${NGINX_BACKEND_PORT}/" /etc/nginx/sites-enabled/001-docker
[ -z "${NGINX_SERVER_NAME}" ] && echo "\$NGINX_SERVER_NAME is not set" || sed -i "s/NGINX_SERVER_NAME/${NGINX_SERVER_NAME}/" /etc/nginx/sites-enabled/001-docker
[ -z "${NGINX_SERVER_NAME_2}" ] && echo "\$NGINX_SERVER_NAME_2 is not set" || sed -i "s/NGINX_SERVER_NAME_2/${NGINX_SERVER_NAME_2}/" /etc/nginx/sites-enabled/001-docker
[ -z "${NGINX_LOG_DIR}" ] && echo "\$NGINX_LOG_DIR is not set" || sed -i "s/NGINX_LOG_DIR/${NGINX_LOG_DIR}/" /etc/nginx/sites-enabled/001-docker

# Start nginx
/usr/sbin/nginx -D FOREGROUND
