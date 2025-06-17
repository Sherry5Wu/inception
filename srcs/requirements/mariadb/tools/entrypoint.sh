#!/bin/sh
# Use the Bourne shell as the script interpreter

# Exit immediately if a command exits with a non-zero status (fail fast)
set -e

echo "Starting MariaDB temporarily for the WordPress database setup..."

# Start MariaDB in bootstrap mode to run initialization SQL commands without starting the full server
mysqld --user=mysql --bootstrap <<EOF
    -- Select the system database
    USE mysql;

    -- Reload privilege tables to ensure they are up to date
    FLUSH PRIVILEGES;

    -- Create the WordPress database if it doesn't already exist
    CREATE DATABASE IF NOT EXISTS ${DB_NAME};

    -- Create the WordPress database user (if not exists) and set the password
    CREATE USER IF NOT EXISTS ${DB_USER}@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';

    -- Grant all privileges on the WordPress database to the user, with the ability to grant further privileges
    GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO ${DB_USER}@'%' WITH GRANT OPTION;

    -- Create the root user for remote access (if not exists) and set the password
    CREATE USER IF NOT EXISTS ${DB_ROOT_USER}@'%' IDENTIFIED BY '${DB_ROOT_PASSWORD}';

    -- Ensure the root user password is set even if the user already exists
    ALTER USER ${DB_ROOT_USER}@'%' IDENTIFIED BY '${DB_ROOT_PASSWORD}';

    -- Reload privilege tables again to apply all changes
    FLUSH PRIVILEGES;
EOF

echo "Starting MariaDB in regular mode..."

# Start MariaDB in safe mode for normal operation
exec mysqld_safe --user=mysql
