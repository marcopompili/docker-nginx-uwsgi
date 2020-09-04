FROM nginx:stable

LABEL author Marco Pompili
LABEL email "docker@mg.odd.red"

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
COPY default.template /etc/nginx/

COPY startup /usr/local/bin/startup

CMD [ "/usr/local/bin/startup" ]
