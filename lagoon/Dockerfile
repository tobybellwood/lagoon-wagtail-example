FROM uselagoon/python-3.11:latest

# Set environment varibles
ENV PYTHONUNBUFFERED 1

# Install dependencies and create the requirements folder.
RUN apk update 
RUN apk add --no-cache enchant2-dev postgresql-client python3-dev gcc libpq-dev libc-dev linux-headers git \
    && mkdir -p /code/requirements

# Copy .lagoon.env & requirements.txt
COPY .lagoon.env /.lagoon.env 
COPY ./requirements.txt /code/requirements.txt

# Install requirements via pip & generate a new wagtail site/project
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r /code/requirements.txt \
    && wagtail start website
