#!/bin/sh

# stopping on error
set -e

echo "Starting MariaDB temporarily for the WordPress database setup..."


mysqld --user=mysql --bootstrap <<EOF
	USE mysql;
	FLUSH PRIVILEGES;
	
	CREATE DATABASE IF NOT EXISTS ${DB_NAME};

	CREATE USER IF NOT EXISTS ${DB_USER}@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';
	GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO ${DB_USER}@'%' WITH GRANT OPTION;

	CREATE USER IF NOT EXISTS ${DB_ROOT_USER}@'%' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
	ALTER USER ${DB_ROOT_USER}@'%' IDENTIFIED BY '${DB_ROOT_PASSWORD}';

	FLUSH PRIVILEGES;
EOF

echo "Starting MariaDB in regular mode..."
exec mysqld_safe --user=mysql
