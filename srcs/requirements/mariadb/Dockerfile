# Use official alpine 3.20 as image
# require the penultimate stable version from subject
# https://alpinelinux.org/releases/
FROM alpine:3.21.3

# 1. updates Alpine's packing index
# 2. Installs MariaDB server and client with no caching(--no -cashe flag is
#    used to avoid storing the package index/cache inside the Docker image).
#    becasue the index is never needed again once the image is built. So keeping
#    it just wastes space.
# 3. "mariadb" is the server;
#    "mariadb-client" is the client;
RUN apk update && \
    apk add --no-cache mariadb mariadb-client

# Prepares the directories MariaDB needs to operate:
#   * /run/mysqld: For PID and socket files;
#   * /var/lib/mysql: Where the database data will be stored
# chown: Sets correct permissions for the MariaDB process(which runs as mysql user)
# mysql_install_db: Initialize the MariaDB database system (create necessary
# tables and files) using the mysql user
# set -eux: this is for debugging.(see more explainatin in README.md)
RUN set -eux; \
    mkdir -p /run/mysqld /var/lib/mysql; \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld; \
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

RUN mkdir -p /var/log/mysql && chown -R mysql:mysql /var/log/mysql

# Copy a custom MariaDB configuration file into the container
COPY ./conf/my-mariadb-server.cnf /etc/my.cnf.d/my-mariadb-server.cnf

# Set read/write permission for the owner and read_only for others on the configuration
RUN chmod 644 /etc/my.cnf.d/my-mariadb-server.cnf

# Decare that the container will listen on port 3306(default MariaDB port)
EXPOSE 3306

# Copy the startup script into the container
COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the container’s entrypoint to the startup script — it will be run when
# the container starts.
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
