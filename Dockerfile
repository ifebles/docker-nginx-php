FROM nginx:1.18.0-alpine

RUN apk add --no-cache ca-certificates curl

# Download de repo public key
RUN curl https://packages.whatwedo.ch/php-alpine.rsa.pub -o /etc/apk/keys/php-alpine.rsa.pub

# add the repo for the php version
RUN echo "https://packages.whatwedo.ch/php-alpine/v3.11/php-7.3" >> /etc/apk/repositories && apk update

RUN apk add php7 php7-fpm \
  php7-opcache php7-mysqli php7-gd \
  php7-zlib php7-curl

RUN adduser -s /sbin/nologin -G www-data -DH www-data

RUN mkdir /etc/nginx/tmp /etc/nginx/custom-conf

# nginx configuration files
COPY nginx/nginx.conf /etc/nginx/
COPY nginx/php.conf nginx/phpfastcgi.conf /etc/nginx/custom-conf/

# PHP configuration files
COPY php/php.ini /etc/php7/
COPY php/www.conf /etc/php7/php-fpm.d/

# PHP validation file
COPY index.php /usr/share/nginx/html/

# Set permissions on /usr/share/nginx/html to www-data
RUN chmod 1775 /usr/share/nginx/html/ && chgrp -R www-data /usr/share/nginx/html/ && chown -R www-data /usr/share/nginx/html/*

# Create commands to restart the services
RUN echo -e "pkill php-fpm7; php-fpm7 && echo \"php-fpm restarted\"" > /usr/local/bin/restart-php && chmod a+x /usr/local/bin/restart-php;
RUN echo "nginx -s reload" > /usr/local/bin/restart-nginx && chmod a+x /usr/local/bin/restart-nginx;

EXPOSE 80

CMD php-fpm7 && nginx-debug -g "daemon off;"