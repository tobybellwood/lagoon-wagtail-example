# Use an official Python runtime as a parent image
FROM uselagoon/python-3.11:latest

# Set environment varibles
ENV PYTHONUNBUFFERED 1

# Install libenchant and create the requirements folder.
RUN apk update 
RUN apk add --no-cache enchant2-dev postgresql-client python3-dev gcc libpq-dev libc-dev linux-headers git \
    && mkdir -p /code/requirements

COPY .lagoon.env /.lagoon.env 
COPY ./requirements.txt /code/requirements.txt

RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r /code/requirements.txt \
    && wagtail start website
