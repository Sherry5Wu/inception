# Use official alpine 3.20 as image
# require the penultimate stable version from subject
FROM alpine:3.20

# 1. updates Alpine's packing index
# 2. Installs MariaDB server and client with no caching(--no -cashe flag is
#    used to avoid storing the package index/cache inside the Docker image).
#    becasue the index is never needed again once the image is built. So keeping
#    it just wastes space.
# 3. "mariadb" is the server;
#    "mariadb-client" is the client;
RUN apk update && \
    apk add --no -cache mariadb mariadb-client

# Prepares the directories MariaDB needs to operate:
#   * /run/mysql: For PID and socket files;
#   * /var/lib/mysql: Where the database data will be stored
# chown: Sets correct permissions for the MariaDB process(which runs as mysql user)
RUN mkdir -p /run/mysqld && \
    mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld




