#!/bin/sh
set -e

# Generate a self-signed SSL-TLS certificate and a private key using openSSL
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-out "$"
