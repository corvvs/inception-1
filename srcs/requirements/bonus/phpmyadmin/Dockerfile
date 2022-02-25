FROM alpine:3.14

RUN apk update && apk upgrade && apk add --no-cache \
	wget	\
	tar

WORKDIR /var/www/html

COPY ./tools/run.sh /tmp/run.sh
CMD ["sh", "/tmp/run.sh"]
