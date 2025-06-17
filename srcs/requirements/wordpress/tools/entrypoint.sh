#!/bin/bash
# Use Bash as the script interpreter

# Exit immediately if any command fails (fail fast)
set -e

# Change to the WordPress document root
cd /var/www/html

 # If this is the first time the volume is mounted (marker file doesn't exist)
if [ ! -e .firstmount ]; then
    # Wait for MariaDB to be ready before proceeding
    mariadb-admin ping --protocol=tcp --host=mariadb -u$DB_USER -p$DB_USER_PASSWORD --wait >/dev/null 2>/dev/null

    # If wp-config.php doesn't exist, assume WordPress isn't installed yet
    if [ ! -f wp-config.php ]; then

        # Download the WordPress core files (ignore failure, e.g. if already downloaded)
        ./wp-cli.phar core download --allow-root || true

        # Create wp-config.php with the database connection details
        ./wp-cli.phar config create --allow-root \
            --dbname="$DB_NAME" \
            --dbuser="$DB_USER" \
            --dbpass="$DB_USER_PASSWORD" \
            --dbhost="$DB_HOST"

        # Install WordPress with site and admin user details
        ./wp-cli.phar core install --allow-root \
            --skip-email \
            --url="$WP_URL" \
            --title="$WP_TITLE" \
            --admin_user="$WP_ADMIN" \
            --admin_password="$WP_ADMIN_PASSWORD" \
            --admin_email="$WP_ADMIN_EMAIL"

        # Create an additional WordPress user with the specified role
        ./wp-cli.phar user create --allow-root $WP_USER $WP_USER_EMAIL --role=$WP_USER_ROLE --user_pass=$WP_USER_PASSWORD


    else
        # Notify if WordPress is already set up
        echo "Wordpress is already installed."

    fi

    chmod o+w -R /var/www/html/wp-content
    # Ensure the wp-content directory is writable by others (needed for uploads, plugins)

    touch .firstmount
    # Create a marker file so this block doesn't run again on next container start
fi

# Start PHP-FPM in the foreground (required for container process)
exec php-fpm83 -F
