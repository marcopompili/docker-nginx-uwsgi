#!/bin/sh

NGINX_VARS='$NGINX_HOST:$NGINX_PORT:$DJANGO_STATIC_URL:$DJANGO_STATIC_PATH:$DJANGO_MEDIA_URL:$DJANGO_MEDIA_PATH'

envsubst "$NGINX_VARS" < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf

mkdir -p $DJANGO_STATIC_PATH
mkdir -p $DJANGO_MEDIA_PATH

nginx -g "daemon off;"
