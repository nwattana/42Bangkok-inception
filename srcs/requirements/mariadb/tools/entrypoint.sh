#!/bin/sh

/etc/init.d/mariadb start

if [ -d "/var/lib/mysql/$MARIADB_NAME" ]
then
	echo "Database exists"
else
# Enter current password for root (enter for none):

# Switch to unix_socket authentication [Y/n]: Y
# Change the root password? [Y/n] : Y
# New password: 
# Re-enter new password: 
# Remove anonymous users? [Y/n] : Y
# Disallow root login remotely? [Y/n] : Y or N
# Remove test database and access to it? [Y/n] : Y
# Reload privilege tables now? [Y/n] : Y

mysql_secure_installation << EOF

Y
Y
$MARIADB_ROOT_PASS
$MARIADB_ROOT_PASS
Y
N
Y
Y
EOF
echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MARIADB_ROOT_PASS'; FLUSH PRIVILEGES;" | mysql -uroot
echo "CREATE DATABASE IF NOT EXISTS $MARIADB_NAME; GRANT ALL ON $MARIADB_NAME.* TO '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_USER_PASS'; FLUSH PRIVILEGES;" | mysql -uroot
mysql -uroot -p$MARIADB_ROOT_PASS $MARIADB_NAME < /usr/local/bin/wordpress.sql

fi

/etc/init.d/mariadb stop

exec "$@"