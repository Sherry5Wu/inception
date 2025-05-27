#!/bin/sh
set -e

# entrypoint steps:
# 1. Waits for the database to be ready.
# 2. Uses wp-cli to configure or install WordPress.
# 3. Sets up proper file permissions.
# 4. Starts PHP-FPM.


# Wait for the database to be ready
echo "Waiting for the MariaDB to be ready..."
while ! mysqladmin ping -h"$DB_HOST" --silent; do
	echo "MariaDB is unavailable -- sleeping..."
	sleep 2
done
echo "MariaDB is up!"

# Set proper file ownership
echo "Fixing permissions on /var/www/html..."
chown -R www-data:www-data /var/www/html
chmod -R 775 /var/www/html

# If WordPress is not installed, install it
if ! wp core is-installed --allow-root; then
	echo "WordPress not found, installing..."

	# Download WordPress core files
	wp core download --allow-root

	 # Create wp-config.php
	wp config create --allow-root \
		--dbname="$DB_NAME" \
		--dbuser="$DB_USER" \
		--dbpass="$DB_PASSWORD" \
		--dbhost="$DB_HOST"

	# Set Redis cache settings (for bouns)
	wp config set WP_REDIS_HOST 'redis' --allow-root
	wp config set WP_REDIS_PORT 6379 --raw --allow-root
	wp config set WP_CACHE true --raw --allow-root


	echo "Installing WordPress..."
	wp core install --allow-root \
		--url="$DOMAIN_NAME" \
		--title="$WP_TITLE" \
		--admin_user="$WP_ADMIN" \
		--admin_password="$WP_ADMIN_PWD" \
		--admin_email="$WP_USER_EMAIL"

	echo "Creating an additional user..."
	wp user create "$WP_USER" "$WP_USER_EMAIL" --role=author \
		--user_pass="$WP_USER_PWD" --allow-root

	wp theme install generatepress --activate --allow-root

	# Install and activate the Redis Object Cache plugin
	wp plugin install redis-cache --activate --allow-root

	# Enable object caching within WordPress
	wp redis enable --allow-root
else
	echo "WordPress already installed, skipping setup."
fi

# Start PHP_FPM
echo "Starting PHP-FPM..."

# Starting PHP-FPM  in foreground mode
exec php-fpm81 --nodaemonize

