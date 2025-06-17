FROM alpine:3.21.3


# Update package index, install MariaDB server, client, and bash
# Create necessary directories for MariaDB runtime
# Set ownership of these directories to the mysql user
# Initialize the MariaDB data directory
RUN apk update && \
	apk add --no-cache mariadb mariadb-client bash && \
	mkdir -p /var/lib/mysql /run/mysqld /var/log/mysql && \
	chown -R mysql:mysql /var/lib/mysql /run/mysqld /var/log/mysql && \
	mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY conf/mariadb-server.cnf /etc/my.cnf.d/
COPY tools/entrypoint.sh /usr/local/bin/

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose the default MariaDB port
EXPOSE 3306


# Set the container entrypoint to the custom script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
