#!/bin/sh

set -e

# Validate required env vars
: "${CERTS_:?Environment variable CERTS_ is not set}"
: "${CERTS_KEY_:?Environment variable CERTS_KEY_ is not set}"
: "${DOMAIN_NAME:?Environment variable DOMAIN_NAME is not set}"

# Create directory for certificates if needed
  # "dirname "$CERTS_"" get the certs path
  # "mkdir - p" create the directory recursively
mkdir -p "$(dirname "$CERTS_")"

# Generate self-signed certificate only if not present
  # "req" - Start a certificate request
  # "-x500" - Generate a self-signed certificate (not a certificate signing request)
  # "-nodes" - No password encryption for the private key(easier for automated servers)
  # "-days 365" - The certificate will be valid for 365 days
  # "-newkey rsa:2048" - Generate a new RSA private key with 2048-bit encryption
  # "-out "$CERTS_"" - Save the certificate file to the path in $CERTS_
  # "-keyout "$CERTS_KEY_"" - Save the private key to the path in $CERTS_KEY_
  # "subj "..."" -  Define certificate metadata (used instead of interactive prompt)
if [ ! -f "$CERTS_" ] || [ ! -f "$CERTS_KEY_" ]; then
	echo "Generating certificate for $DOMAIN_NAME..."
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-out "$CERTS_" \
		-keyout "$CERTS_KEY_" \
		-subj "/C=FI/L=Helsinki/O=Hive/OU=Student/CN=$DOMAIN_NAME"
	chmod 644 "$CERTS_"
	chmod 600 "$CERTS_KEY_"
else
	echo "Certificates exist. Skipping generation."
fi

# Replace placeholders in the Nginx config
  # "sed" - is the stream editor used to modify files.
  # "-i" - means “in-place” – directly modifies the file instead of printing to output.
  # "s|pattern|replacement|g" - is the substitution syntax
  # "-e" - allows multiple expressions (substitutions) to be stacked.
  # "-g" - means “global” – replace all occurrences in each line.
  # "-e "s|\${CERTS_}|$CERTS_|g" " - Find ${CERTS_} in the file, and replace it with the
  # value of the variable $CERTS_
  # "/etc/nginx/http.d/default.conf" - This is the target file: the Nginx config file
  # that will be updated.
sed -i \
	-e "s|\${CERTS_}|$CERTS_|g" \
	-e "s|\${CERTS_KEY_}|$CERTS_KEY_|g" \
	-e "s|\${DOMAIN_NAME}|$DOMAIN_NAME|g" \
  /etc/nginx/nginx.conf
# /etc/nginx/conf.d/default.conf
	# /etc/nginx/http.d/default.conf

# Start Nginx in foreground
echo "Starting Nginx..."
exec nginx -g "daemon off;"
