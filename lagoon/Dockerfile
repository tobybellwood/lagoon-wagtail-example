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
# COPY ./bakerydemo/requirements/* /code/requirements/
RUN mv ./bakerydemo/requirements/* /code/requirements/
RUN pip install --upgrade pip 
RUN pip install uwsgi
RUN pip install -r /code/requirements/production.txt

# Clone wagtail. This folder will be overwritten by a volume mount during run time (so that code
# changes show up immediately), but it also needs to be copied into the image now so that wagtail can be pip install'd.
RUN git clone https://github.com/wagtail/wagtail.git /code/wagtail/
RUN cd /code/wagtail/ \
    && pip install -e .[testing,docs]

# Clone Willow. This folder will be overwritten by a volume mount during run time (so that code
# changes show up immediately), but it also needs to be copied into the image now so that Willow can be pip install'd.
RUN git clone https://github.com/wagtail/Willow.git /code/willow/
RUN cd /code/willow/ \
    && pip install -e .[testing]