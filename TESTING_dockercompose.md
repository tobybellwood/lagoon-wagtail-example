Docker Compose Wagtail - python, postgres
========================================================

This is a docker-compose version of the Lando example tests:

Start up tests
--------------

Run the following commands to get up and running with this example.

```bash
# Should remove any previous runs and poweroff
docker network inspect amazeeio-network >/dev/null || docker network create amazeeio-network
docker-compose down

# Should start up our Lagoon Wagtail site successfully
docker-compose build && docker-compose up -d

# Ensure postgres pod is ready to connect, then sleep for 60s
docker run --rm --net lagoon-wagtail-example_default amazeeio/dockerize dockerize -wait tcp://postgres:5432 -timeout 1m

```

Verification commands
---------------------

Run the following commands to validate things are rolling as they should.

```bash
# Should have all the services we expect
docker ps --filter label=com.docker.compose.project=lagoon-wagtail-example | grep Up | grep lagoon-wagtail-example_python_1
docker ps --filter label=com.docker.compose.project=lagoon-wagtail-example | grep Up | grep lagoon-wagtail-example_postgres_1

# Should ssh against the python container by default
docker-compose exec -T python sh -c "env | grep LAGOON=" | grep python

# Should have the correct environment set
docker-compose exec -T python sh -c "env" | grep LAGOON_ROUTE | grep lagoon-wagtail-example.docker.amazee.io

# Should be running python 3.11
docker-compose exec -T python sh -c "python3 --version" | grep "Python 3.11"

# Should have Uwsgi
docker-compose exec -T python sh -c "uwsgi --version" | grep 2.0.21

# Should have dependencies via pip - uwsgi, wagtail
docker-compose exec -T python sh -c "pip list" | grep uWSGI
docker-compose exec -T python sh -c "pip list" | grep wagtail
docker-compose exec -T python sh -c "pip list" | grep Django

# Should have a running site served by uwsgi on port 8800
docker-compose exec -T python sh -c "curl -kL http://localhost:8800" | grep "Wagtail"

# Should be able to db-export and db-import the database
docker-compose exec -T python sh -c "/code/mysite/manage.py dumpdata --natural-foreign --natural-primary -e contenttypes -e auth.Permission --indent 2 > /code/dump.json"
docker-compose exec -T python sh -c "/code/mysite/manage.py loaddata /code/dump.json"

# Should be able to show the 'articles' tables
docker-compose exec -T python sh -c "/code/mysite/manage.py inspectdb wagtailcore_site" | grep "wagtailcore_site"

# Should be able to rebuild and persist the database
docker-compose build && docker-compose up -d
docker-compose exec -T python sh -c "/code/mysite/manage.py inspectdb wagtailcore_site" | grep "wagtailcore_site"
```

Destroy tests
-------------

Run the following commands to trash this app like nothing ever happened.

```bash
# Should be able to destroy our rails site with success
docker-compose down --volumes --remove-orphans
```