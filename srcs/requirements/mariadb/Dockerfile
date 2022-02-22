FROM alpine:3.15

RUN apk update && apk upgrade && apk add --no-cache \
	mariadb mariadb-client mariadb-common mariadb-server-utils pwgen && \
	rm -rf /var/cache/apk/*

COPY ./tools/run.sh /tmp/run.sh
RUN chmod +x /tmp/run.sh

CMD sh /tmp/run.sh
