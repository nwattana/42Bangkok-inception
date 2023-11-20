# FROM debian:bullseye

# RUN apt-get update && apt-get install -y vim
# RUN apt-get update && apt-get -y install \
#     wget \
# 	bash \
# 	php \
# 	php-cgi \
# 	php-mysql \
# 	php-fpm \
# 	php-pdo \
# 	php-gd \
# 	php-cli \
# 	php-mbstring

# RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
# 	chmod +x wp-cli.phar && \
# 	mv wp-cli.phar /usr/local/bin/wp

# RUN apt update && apt install -y net-tools fish

# RUN mkdir /run/php

# # COPY ./scripts/wordpress.sh /usr/local/bin/
# # RUN chmod +x /usr/local/bin/wordpress.sh
# # RUN /usr/local/bin/wordpress.sh
# RUN wget http://wordpress.org/latest.tar.gz
# RUN tar -xpvf latest.tar.gz
# RUN mv wordpress/* .
# RUN rm -rf latest.tar.gz
# RUN rm -rf wordpress
# RUN cp wp-config-sample.php wp-config.php
# RUN sed -i "s/username_here/$WORDPRESS_DB_USER/g" wp-config.php 
# RUN sed -i "s/password_here/$WORDPRESS_DB_PASS/g" wp-config.php 
# RUN sed -i "s/localhost/$WORDPRESS_DB_HOST/g" wp-config.php 
# RUN sed -i "s/database_name_here/$WORDPRESS_DB_NAME/g" wp-config.php
# # RUN cp wp-config.php /var/www/html/
# # &&\
# # /usr/local/bin/wp user create $WORDPRESS_ADMIN_USER $WORDPRESS_ADMIN_EMAIL --role=administrator --user_pass=$WORDPRESS_ADMIN_PASSWORD --allow-root &&\
# # /usr/local/bin/wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL --role=author --user_pass=$WORDPRESS_USER_PASSWORD --allow-root

# WORKDIR /var/www/html/


# EXPOSE 9000


# # CMD ["tail", "-f", "/dev/null"]
# CMD ["/usr/sbin/php-fpm7.4", "-F"]

# Base Image
FROM debian:bullseye

# # Set environment variables to non-interactive
# ENV DEBIAN_FRONTEND=noninteractive

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

RUN sed -i "s/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/g" /etc/php/7.4/fpm/pool.d/www.conf 
RUN sed -i "s/pm.max_children = 5/pm.max_children = 25/g" /etc/php/7.4/fpm/pool.d/www.conf 
RUN sed -i "s/pm.max_spare_servers = 3/pm.max_spare_servers = 10/g" /etc/php/7.4/fpm/pool.d/www.conf 
RUN sed -i "s/pm.start_servers = 2/pm.start_servers = 5/g" /etc/php/7.4/fpm/pool.d/www.conf

COPY ./tools/entrypoint.sh /usr/local/bin/

RUN mkdir /run/php

RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

WORKDIR /var/www/html/

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.4", "-F"]
