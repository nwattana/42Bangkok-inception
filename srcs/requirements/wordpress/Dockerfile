FROM debian:bookworm
# https://www.debian.org/releases/

# Update and upgrade the system packages
RUN apt-get update && apt-get -y install \
    wget \
    curl \
    bash \
    php \
    php-cgi \
    php-mysql \
    php-fpm \
    php-pdo \
    php-gd \
	php-cli \
    php-mbstring

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Set FPM
RUN sed -i "s/listen = \/run\/php\/php8.2-fpm.sock/listen = 0.0.0.0:9000/g" /etc/php/8.2/fpm/pool.d/www.conf
# Increase capability avoid 502
# RUN sed -i "s/pm.max_children = 5/pm.max_children = 25/g" /etc/php/7.4/fpm/pool.d/www.conf 
# RUN sed -i "s/pm.max_spare_servers = 3/pm.max_spare_servers = 10/g" /etc/php/7.4/fpm/pool.d/www.conf 
# RUN sed -i "s/pm.start_servers = 2/pm.start_servers = 5/g" /etc/php/7.4/fpm/pool.d/www.conf

COPY ./tools/entrypoint.sh /usr/local/bin/

RUN mkdir -p /run/php

RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

WORKDIR /var/www/html/

EXPOSE 9000

# CMD ["tail", "-f", "/dev/null"] 
CMD ["/usr/sbin/php-fpm8.2", "-F"]
