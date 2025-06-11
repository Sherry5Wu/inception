#!/bin/sh

# stopping on error
set -e

echo "Starting MariaDB temporarily for the WordPress database setup..."

# Starts the mysqld (MariaDB server) process in the background (&)
# Temporarily start just for setup proposes, usually in the backgroud and without
# full production configuration
mysqld &

# Wait for MariaDB to start in a certain time
# "mysqladmin" allows you to perform administrative operations on the database
# server directly from the terminal.
timeout=60
while ! mysqladmin ping --silent; do
	echo "Waiting for MariaDB to start..."
	sleep 2;
	timeout=$((timeout - 2))
	# "le" = less than or equal
	if [ $timeout -le 0 ]; then
	echo "MariaDB didn't start within expected time."
	exit 1
	fi
done

# "Drop database....privileges" passed to execute
# '%' → allows connections from any IP address
# $DB_NAME.* → all tables in the given database
if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
	echo "Creating WordPress database and user, setting permission..."
	# mysql -u root --execute \
	# "Drop database if exists $DB_NAME;
	# Create database $DB_NAME;
	# Create user if not exists '$DB_USER'@'%' identified by '$DB_PASSWORD';
	# Grant all privileges on $DB_NAME.* to '$DB_USER'@'%';
	# Flush privileges;"

	# Setup with root password
  mysql -u root <<-EOSQL
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
    FLUSH PRIVILEGES;
    DROP DATABASE IF EXISTS ${DB_NAME};
    CREATE DATABASE ${DB_NAME};
    CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL
else
	echo "WordPress database already exists. Skipping WordPress database setup"
fi

# Shut down mysqld process
# mysqladmin -u root shutdown
mysqladmin -u root -p"${DB_ROOT_PASSWORD}" shutdown


echo "Starting MariaDB in regular mode..."
exec mysqld
