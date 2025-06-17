# Use Alpine Linux 3.21.3 as the lightweight base image
FROM alpine:3.21.3

# Update package index and install required packages:
# - bash: shell environment
# - curl: for downloading files
# - mariadb-client: MariaDB command line client
# - PHP 8.3 and common PHP extensions needed for WordPress
RUN apk update && \
    apk add --no-cache \
        bash curl mariadb-client \
        php83 php83-fpm php83-mysqli php83-json php83-curl php83-dom \
        php83-mbstring php83-openssl php83-xml php83-phar php83-session && \

    # Create 'www-data' group and user (if they don't already exist)
    addgroup -S www-data || true && \
    adduser -S -G www-data www-data || true && \

    # Create the web root directory and set ownership and permissions
    mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Set the working directory inside the container
WORKDIR /var/www/html

# Download wp-cli tool for managing WordPress from official source
# Make it executable
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar

# Copy custom PHP-FPM pool configuration for www into the container
COPY conf/www.conf /etc/php83/php-fpm.d/

# Copy the entrypoint script that will initialize and start services
COPY tools/entrypoint.sh /usr/local/bin/

# Make entrypoint script executable
# Increase PHP memory limit to 512M by modifying php.ini or appending if missing
RUN chmod +x /usr/local/bin/entrypoint.sh && \
    sed -i '/^memory_limit\s*=/c\memory_limit = 512M' /etc/php83/php.ini || \
    echo "memory_limit = 512M" >> /etc/php83/php.ini

# Set the container entrypoint to the custom initialization script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
