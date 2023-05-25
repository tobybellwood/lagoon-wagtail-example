FROM uselagoon/python-3.11:latest

# Set environment varibles
ENV PYTHONUNBUFFERED 1

# Install dependencies and create the requirements folder.
RUN apk update 
RUN apk add --no-cache enchant2-dev postgresql-client python3-dev gcc libpq-dev libc-dev linux-headers \
    && mkdir -p /code

WORKDIR /code

# Copy .lagoon.env & requirements.txt
COPY /mysite /code/mysite
COPY .lagoon.env /code/.lagoon.env 

# Install requirements via pip & generate a new wagtail site/project
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r /code/mysite/requirements.txt \
    && pip install uwsgi 

CMD ["/bin/sh", "-c", "/code/mysite/manage.py migrate && uwsgi --http :8000 --module mysite.wsgi"]
