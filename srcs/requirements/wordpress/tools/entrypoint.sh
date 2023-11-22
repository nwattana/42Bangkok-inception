#!/bin/sh

if [ -f ./wp-config.php ]
then
	echo "wordpress already downloaded"
else

	wget http://wordpress.org/latest.tar.gz
	tar -xpvf latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress

	cp wp-config-sample.php wp-config.php
	sed -i "s/username_here/$WORDPRESS_DB_USER/g" wp-config.php
	sed -i "s/password_here/$WORDPRESS_DB_PASS/g" wp-config.php
	sed -i "s/localhost/$WORDPRESS_DB_HOST/g" wp-config.php
	sed -i "s/database_name_here/$WORDPRESS_DB_NAME/g" wp-config.php

	wp user create  --allow-root $WORDPRESS_ADMIN_USER $WORDPRESS_ADMIN_EMAIL --role=administrator --user_pass=$WORDPRESS_ADMIN_PASS --display_name=admin
	wp user create  --allow-root $WORDPRESS_USER $WORDPRESS_USER_EMAIL --role=editor --user_pass=$WORDPRESS_USER_PASS --display_name=user1
fi

exec "$@"