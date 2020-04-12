FROM nginx:1.15.8-alpine

RUN apk add curl php7 php7-fpm php7-opcache php7-mysqli php7-gd php7-zlib php7-curl;

RUN addgroup www-data && adduser -s /sbin/nologin -G www-data -DH www-data;

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

# Create aliases to restart the services
RUN echo -e "alias restart-php=\"pkill php-fpm7; php-fpm7 && echo php-fpm restarted\"\nalias restart-nginx=\"nginx -s reload\"" >> ~/.profile && source ~/.profile

EXPOSE 80

CMD php-fpm7 && nginx-debug -g "daemon off;"