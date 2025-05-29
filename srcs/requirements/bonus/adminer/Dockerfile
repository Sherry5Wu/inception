FROM alpine:3.20.6

# php81-session: for managing user logins and state across requests
# php81-mysqli: allows Adminer to connect to MySQL databases
# php81-json: handles requests or responses that involve JSON data
# curl: used to download Adminer
RUN apk update && \
	apk add --no-cache php81 php81-session \
	php81-mysqli php81-json curl

# Creates the /var/www directory (Adminer's document root)
# Downloads the latest Adminer PHP file and saves it as index.php in that directory.
RUN mkdir -p /var/www && \
	curl -L https://www.adminer.org/latest.php -o /var/www/index.php

# Adminer will be accessible at http://localhost:8080 (or through mapped ports).
EXPOSE 8080

# Defines the command that runs when the container starts
# Listens on all interfaces at port 8080.
# Uses /var/www as the web root (where index.php lives).
ENTRYPOINT [ "php81", "-S", "0.0.0.0:8080", "-t", "/var/www" ]
