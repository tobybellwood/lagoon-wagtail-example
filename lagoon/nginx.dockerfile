ARG WEB_IMAGE
FROM ${WEB_IMAGE} as web
FROM uselagoon/nginx:latest

COPY --from=web /website /app

# COPY lagoon/nginx/nginx.conf /etc/nginx/nginx.conf
COPY lagoon/nginx/website_nginx.conf /etc/nginx/sites-available/
COPY ./uwsgi_params /etc/nginx/uwsgi_params

RUN mkdir -p /etc/nginx/sites-enabled/\
    && ln -s /etc/nginx/sites-available/website_nginx.conf /etc/nginx/sites-enabled/
    
CMD ["nginx", "-g", "daemon off;"]

EXPOSE 8080