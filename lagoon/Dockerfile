# Use an official Python runtime as a parent image
FROM uselagoon/python-3.11:latest

# Set environment varibles
ENV PYTHONUNBUFFERED 1

# Install libenchant and create the requirements folder.
RUN apk update 
RUN apk add --no-cache enchant2-dev postgresql-client python3-dev gcc libpq-dev libc-dev linux-headers git \
    && mkdir -p /code/requirements

# Install the bakerydemo project's dependencies into the image.
RUN git clone https://github.com/wagtail/bakerydemo.git
RUN mv ./bakerydemo/requirements/* /code/requirements/
RUN pip install --upgrade pip 
RUN pip install -r /code/requirements/production.txt

# Copy in requirements.txt and install dependencies.
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt
