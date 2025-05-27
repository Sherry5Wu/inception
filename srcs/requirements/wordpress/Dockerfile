FROM alpine:3.20.6

# 1. Install PHP and dependencies
# "php81-fpm" FastCGI Process Manager for serving PHP
# "php81-mysqli" MySQL/MariaDB database connectivity
# "php81-phar" Needed for WP-CLI
# "php81-tokenizer" Required for some plugins/themes
# "php81-mbstring" Multibyte string support (used in i18n)
# "php81-iconv" Character encoding conversion
# "Mariadb-client"  is the command-line client for interacting with MariaDB or MySQL databases
# 2. download and install WP-CLI
# WP_CLI is a command-line tool for managing WordPress sites.
RUN apk update && \
	apk add --no-cache php81 php81-fpm php81-mysqli php81-phar \
	php81-tokenizer php81-mbstring php81-iconv mariadb-client && \
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

# copy the configuration file
COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf

# Create PHP run directory
# "-p" : stands for "parents", create all necessary parent directories if they
# don’t already exist
RUN mkdir -p /run/php

# Create a system user www-data and assign it to the group www-data
# which is commonly used for web services
RUN adduser  -S www-data -G www-data

# Set working directory for WordPress and adjust permissions
# Ensure that the www-data user has appropriate permissions to work in /var/www/html
# if WordPress files will be written there during runtime.
# "-R":  stands for "recursive".It tells chown to apply the ownership change to all
# files and subdirectories inside /var/www/html
# syntax for chown: chown [option] user:group file
WORKDIR /var/www/html
RUN mkdir -p /var/www/html && \
	chown -R www-data:www-data /var/www/html

# create a symlink that allows the command php to point to the php81 executable
RUN ln -s /usr/bin/php81 /usr/bin/php

# Copy entrypoint and make executable
COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

#expose the port PHP-FPM will listen on
# 9000 is the default port used by PHP-FPM
EXPOSE 9000

# Switch to non-root user for runtime
USER www-data

# Use absolute path for entrypoint
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
