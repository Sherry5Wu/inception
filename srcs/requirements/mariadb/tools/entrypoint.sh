#!/bin/sh

echo "Starting MariaDB temporarily for the WordPress database setup..."
mysqld &

# Wait for MariaDB to start
sleep 2
until mysqladmin ping --slient; do
	echo "Waiting for MariaDB to start..."
	sleep 2
done

if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
	echo "Creating WordPress database and user, setting permission..."
	mysql -u root --execute \
	"Drop database if exists $DB_NAME;
	Create database $DB_NAME;
	Create user if not exists '$DB_USER'@'%' identified by '$DB_PASSWORD';
	Grant all priviledges on $DB_NAME.* to '$DB_USER'@'%';
	Flush privileges;
	"
else
	echo "WordPress database already exists. Skipping WordPress database setup"
fi

# Shut down mysqld process
mysqladmin -u root shutdown

echo "Starting MariaDB in regular mode..."
exec mysqld
