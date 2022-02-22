# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    run.sh                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dpoveda- <me@izenynn.com>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/02/22 19:15:20 by dpoveda-          #+#    #+#              #
#    Updated: 2022/02/23 00:24:17 by dpoveda-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

# wait until database is ready
while ! mariadb -h$MYSQL_HOST -u$WP_DB_USER -p$WP_DB_PASSWORD $WP_DB_NAME --silent; do
	echo "FKLSJDLKFJSDKFJL"
	sleep 1;
done

# check if website already created
if [ ! -f "/var/www/html/index.html" ]; then
	# static website
	#mv /tmp/static-web/* /var/www/html/

	# adminer

	echo "KJDSFLKSJDFLKJSKDLFJKLSDJFLKSJDF:SDKFJSKLDJFKLSDJFLKSDJFLKSDJFKLDSJ"
	echo "KJDSFLKSJDFLKJSKDLFJKLSDJFLKSJDF:SDKFJSKLDJFKLSDJFLKSDJFLKSDJFKLDSJ"
	echo "KJDSFLKSJDFLKJSKDLFJKLSDJFLKSJDF:SDKFJSKLDJFKLSDJFLKSDJFLKSDJFKLDSJ"
	echo "KJDSFLKSJDFLKJSKDLFJKLSDJFLKSJDF:SDKFJSKLDJFKLSDJFLKSDJFLKSDJFKLDSJ"
	echo "KJDSFLKSJDFLKJSKDLFJKLSDJFLKSJDF:SDKFJSKLDJFKLSDJFLKSDJFLKSDJFKLDSJ"
	echo "KJDSFLKSJDFLKJSKDLFJKLSDJFLKSJDF:SDKFJSKLDJFKLSDJFLKSDJFLKSDJFKLDSJ"

	# wp-cli
	wp core download --allow-root
	wp config create --dbname=$WP_DB_NAME --dbuser=$WP_DB_USER --dbpass=$WP_DB_PASSWORD \
		--dbhost=$MYSQL_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
	wp core install --url=$DOMAIN_NAME/wordpress --title=$WP_TITLE --admin_user=$WP_ADMIN_USER \
		--admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
	wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASSWORD --allow-root
	wp theme install ryu --activate --allow-root

	# redis
	# TODO
fi

echo "PATATAAAAAAAAAAAAAAA"
echo "PATATAAAAAAAAAAAAAAA"
echo "PATATAAAAAAAAAAAAAAA"
echo "PATATAAAAAAAAAAAAAAA"
echo "PATATAAAAAAAAAAAAAAA"
echo "PATATAAAAAAAAAAAAAAA"


while true; do
	sleep 1
done

#php-fpm7 -F -R
php-fpm7 --nodaemonize
