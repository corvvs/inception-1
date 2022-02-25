FROM alpine:3.14

RUN apk update && apk upgrade && apk add --no-cache \
	redis;

COPY ./conf/redis.conf /tmp/redis.conf

COPY ./tools/run.sh /tmp/run.sh
CMD ["sh", "/tmp/run.sh"]
