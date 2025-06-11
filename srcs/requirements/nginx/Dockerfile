FROM alpine:3.21.3

# Install NGINX and OpenSSL for TLS
RUN apk update && \
    apk add --no-cache nginx openssl

# Copy NGINX config
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Copy entrypoint script
COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose HTTPS port
EXPOSE 443

# Start the container with the custom entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
