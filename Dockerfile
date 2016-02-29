FROM nginx:latest

MAINTAINER Marco Pompili <marcs.pompili@gmail.com>

ENV NGINX_HOST localhost
ENV NGINX_PORT 80
ENV DJANGO_STATIC_URL /static/
ENV DJANGO_STATIC_PATH /srv/django/static/
ENV DJANGO_MEDIA_URL /media/
ENV DJANGO_MEDIA_PATH /srv/django/media/
ENV UWSGI_HOST uwsgi_srv
ENV UWSGI_PORT 8000

RUN mkdir -p /srv/django/static/ && \
    mkdir -p /srv/django/media/

VOLUME ["/srv/django/static/", "/srv/django/media/"]

COPY uwsgi_params /etc/nginx/
COPY default.template /etc/nginx/conf.d/
COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT ["entrypoint.sh"]
