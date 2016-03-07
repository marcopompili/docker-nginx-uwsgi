FROM emarcs/debian-minit:jessie

MAINTAINER Marco Pompili <marcs.pompili@gmail.com>

RUN apt-get -q -q update && \
    apt-get -y install gettext-base nginx

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV NGINX_HOST 0.0.0.0
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

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

COPY uwsgi_params /etc/nginx/
COPY default.template /etc/nginx/conf.d/

COPY startup /etc/minit/
