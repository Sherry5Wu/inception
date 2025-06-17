#!/bin/bash
set -e

cd /var/www/html

if [ ! -e .firstmount ]; then
	# Wait for MariaDB to be ready
	mariadb-admin ping --protocol=tcp --host=mariadb -u$DB_USER -p$DB_USER_PASSWORD --wait >/dev/null 2>/dev/null

	if [ ! -f wp-config.php ]; then
		./wp-cli.phar core download --allow-root || true
		./wp-cli.phar config create --allow-root \
			--dbname="$DB_NAME" \
			--dbuser="$DB_USER" \
			--dbpass="$DB_USER_PASSWORD" \
			--dbhost="$DB_HOST"
		./wp-cli.phar core install --allow-root \
			--skip-email \
			--url="$WP_URL" \
			--title="$WP_TITLE" \
			--admin_user="$WP_ADMIN" \
			--admin_password="$WP_ADMIN_PASSWORD" \
			--admin_email="$WP_ADMIN_EMAIL"
		./wp-cli.phar user create --allow-root $WP_USER $WP_USER_EMAIL --role=$WP_USER_ROLE --user_pass=$WP_USER_PASSWORD

	else
		echo "Wordpress is already installed."
	fi
	chmod o+w -R /var/www/html/wp-content
	touch .firstmount
fi

exec php-fpm83 -F
