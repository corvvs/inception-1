FROM alpine:3.14

RUN apk update && apk upgrade && apk add --no-cache \
	vsftpd;

COPY ./conf/vsftpd.conf /tmp/vsftpd.conf

COPY ./tools/run.sh /tmp/run.sh
CMD ["sh", "/tmp/run.sh"]
