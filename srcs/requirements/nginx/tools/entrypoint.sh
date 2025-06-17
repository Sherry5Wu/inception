#!/bin/sh
set -e

openssl req -x509 -days 365 -newkey rsa:2048 -nodes \
			-keyout /etc/nginx/ssl/cert.key \
			-out /etc/nginx/ssl/cert.crt \
			-subj "/CN=$DOMAIN_NAME"

chmod 600 /etc/nginx/ssl/cert.key
chmod 644 /etc/nginx/ssl/cert.crt

exec nginx -g "daemon off;"
