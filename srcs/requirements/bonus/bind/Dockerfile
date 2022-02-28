FROM alpine:3.14

RUN apk update && apk upgrade && apk add --no-cache \
	bind

COPY ./conf/named.conf /tmp/named.conf
COPY ./conf/dpoveda.42.fr.zone /tmp/dpoveda.42.fr.zone

COPY ./tools/run.sh /tmp/run.sh
CMD ["sh", "/tmp/run.sh"]
