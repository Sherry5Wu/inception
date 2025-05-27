FROM alpine:3.20.6

RUN apk update && \
	apk add --no-cache nginx openssl

COPY ./conf/ngnix.conf /ect/ngnix/nginx.conf && \
	./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 443

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
