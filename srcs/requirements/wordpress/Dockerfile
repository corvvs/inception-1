FROM alpine:3.14

ENV DB_HOST="127.0.0.1"

RUN apk update && apk upgrade && apk add --no-cache \
	bash less vim nano git mariadb-client ca-certificates \
	php7 php7-fpm php7-json php7-zlib php7-xml php7-pdo php7-phar php7-openssl \
	php7-pdo_mysql php7-mysqli php7-mysqlnd \
	php7-gd php7-mcrypt \
	php7-curl php7-opcache php7-ctype  \
	php7-intl php7-bcmath php7-dom php7-xmlreader

# php
RUN adduser -S nginx && addgroup -S nginx
COPY ./conf/php-fpm.conf /etc/php7/php-fpm.conf
COPY ./conf/www.conf /etc/php7/php-fpm.d/www.conf

# static website
RUN mkdir /tmp/static-web
COPY ./conf/static-web/ /tmp/static-web/

# wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp && chmod +x /usr/local/bin/wp

WORKDIR /var/www/html/wordpress

COPY ./tools/run.sh /tmp/run.sh
CMD ["sh", "/tmp/run.sh"]
