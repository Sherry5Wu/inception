FROM alpine:3.21.3

RUN apk update && \
	apk add --no-cache nginx gettext openssl bash && \
	mkdir -p /etc/nginx/ssl

COPY conf/default.conf /etc/nginx/http.d/default.conf
COPY tools/entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
