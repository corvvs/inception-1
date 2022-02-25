FROM alpine:3.14

# static website
RUN mkdir /tmp/website
COPY ./conf/website/ /tmp/website/

COPY ./tools/run.sh /tmp/run.sh
CMD ["sh", "/tmp/run.sh"]
