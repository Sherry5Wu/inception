FROM alpine:3.21.3

# php83-session: for managing user logins and state across requests
# php83-mysqli: allows Adminer to connect to MySQL databases
# php83-json: handles requests or responses that involve JSON data
# curl: used to download Adminer
RUN apk update && \
	apk add --no-cache php83 php83-session \
	php83-mysqli php83-json curl

# Creates the /var/www directory (Adminer's document root)
# Downloads the latest Adminer PHP file and saves it as index.php in that directory.
RUN mkdir -p /var/www && \
	curl -L https://www.adminer.org/latest.php -o /var/www/index.php

# Adminer will be accessible at http://localhost:8080 (or through mapped ports).
EXPOSE 8080

# Defines the command that runs when the container starts
# Listens on all interfaces at port 8080.
# Uses /var/www as the web root (where index.php lives).
ENTRYPOINT [ "php83", "-S", "0.0.0.0:8080", "-t", "/var/www" ]
