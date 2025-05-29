FROM alpine:3.20.6

# Install lighttpd
RUN apk update && \
	apk add --no-cache lighttpd

# Copy website files
COPY app/ /var/www/localhost/htdocs

COPY conf/lighttpd.conf /etc/lighttpd/lighttpd.conf

# Create log dirs (optional, for error logs to work)
RUN mkdir -p /var/log/lighttpd && \
    chown -R lighttpd:lighttpd /var/log/lighttpd

EXPOSE 80

ENTRYPOINT [ "lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf" ]
