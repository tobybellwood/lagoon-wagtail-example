FROM uselagoon/python-3.11:latest

# Set environment varibles
ENV PYTHONUNBUFFERED 1
ENV LAGOON=python

COPY ./lagoon/99_* /lagoon/entrypoints/

# Install dependencies and create the requirements folder.
RUN apk update 
RUN apk add --no-cache enchant2-dev postgresql-client python3-dev gcc libpq-dev libc-dev linux-headers curl \
    && mkdir -p /code

WORKDIR /code

# Copy .lagoon.env & requirements.txt
COPY mysite /code/mysite
COPY .lagoon.env requirements.txt /code/

# Install requirements via pip & generate a new wagtail site/project
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r /code/requirements.txt \
    && pip install --no-cache-dir -r /code/mysite/requirements.txt

CMD ["/bin/sh", "-c", "uwsgi --http :8800 --module mysite.wsgi"]
