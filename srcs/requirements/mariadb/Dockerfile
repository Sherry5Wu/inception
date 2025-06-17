FROM alpine:3.21.3

RUN apk update && \
	apk add --no-cache mariadb mariadb-client bash && \
	mkdir -p /var/lib/mysql /run/mysqld /var/log/mysql && \
	chown -R mysql:mysql /var/lib/mysql /run/mysqld /var/log/mysql && \
	mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY conf/mariadb-server.cnf /etc/my.cnf.d/
COPY tools/entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
