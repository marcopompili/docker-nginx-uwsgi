# docker-nginx-uwsgi

A Docker image for an [Nginx](http://nginx.org/en/) proxy server
for serving [Django](https://www.djangoproject.com/) requests
and static files.

## Installation

Simply install the image from the docker repository:

```shell
docker pull emarcs/nginx-uwsgi
```

## Configuration

This image has some environment variables for configuration.
Here it is a comprehensive list with all the usable variables
and their default values:

```shell
$NGINX_HOST localhost
$NGINX_PORT 80
$DJANGO_STATIC_URL /static/
$DJANGO_STATIC_PATH /srv/django/static/
$DJANGO_MEDIA_URL /media/
$DJANGO_MEDIA_PATH /srv/django/media/
$UWSGI_HOST uwsgi_srv
$UWSGI_PORT 8000
```

Nginx variables are self explanatory, Django variables are used
for serving static files using Nginx, an url and path is needed
for both static e media files.

The static and media files are mounted inside the Nginx container,
instead the Django application is mounted in the Django container.
The proxy server calls the Django container when needed.

## Running the container

This image is specific for serving Django and static requests
in a production environment using the uWSGI module.

You can find a docker-compose example in the source code:

```yml
version: '2'

services:
  nginx_srv:
    image: emarcs/nginx-uwsgi
    ports:
      - 8081:80
    links:
      - uwsgi_srv
    volumes:
      - ./data/static/:/srv/django/static/
      - ./data/media/:/srv/django/media/
  uwsgi_srv:
    image: emarcs/django:latest
    volumes:
      - ./data:/srv/django/app
```

As you can see for a complete Django production environment
at least two containers are needed, one for serving Nginx and
another for serving Django (using uWSGI).

In this example we are using two folders for static and media files
in the nginx_srv container:

*   ./data/static -> /srv/django/static/
*   ./data/media -> /srv/django/media/

In the uwsgi_srv container the application data are mounted from the folder:

*   ./data -> /srv/django/app/

The nginx_srv container is linked with the default hostname
uwsgi_srv so no need to update the environmemnt variable: UWSGI_HOST

## Notes

*   [How to use Django with uWSGI](https://docs.djangoproject.com/en/1.9/howto/deployment/wsgi/uwsgi/)
*   [Nginx HTTP uWSGI module](http://nginx.org/en/docs/http/ngx_http_uwsgi_module.html)
*   [uWSGI documentation](https://uwsgi-docs.readthedocs.org/en/latest/)
