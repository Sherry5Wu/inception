FROM alpine:3.21.3

RUN apk update && \
	apk add --no-cache nginx gettext openssl bash && \
	mkdir -p /etc/nginx/ssl

COPY conf/default.conf /etc/nginx/http.d/default.conf
COPY tools/entrypoint.sh /usr/local/bin/

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the container entrypoint to the custom script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
