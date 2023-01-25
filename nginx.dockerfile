FROM nginx
COPY ./nginx/nginx.conf /etc/nginx/conf.d/nginx.conf
COPY ./templates /usr/share/nginx/html

