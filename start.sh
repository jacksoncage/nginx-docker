#!/bin/bash

# Setup backend/cache port
if [[ -z "$ENV_PORT" ]] ; then
    sed -ie 's/server\ 172\.17\.42\.1\:80/server\ 172\.17\.42\.1\:$ENV_PORT/g' /etc/nginx/sites-available/tennistunering.se
fi

# Start nginx
/usr/sbin/nginx -D FOREGROUND