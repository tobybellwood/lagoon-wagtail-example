#!/bin/sh
set -e

/code/mysite/manage.py migrate

if [ ! -z $DJANGO_SUPERUSER_USERNAME ] && [ ! -z $DJANGO_SUPERUSER_PASSWORD ] && [ ! -z $DJANGO_SUPERUSER_EMAIL ]; then
	/code/mysite/manage.py createsuperuser --no-input
fi

exec "$@"