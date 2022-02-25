# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    run.sh                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dpoveda- <me@izenynn.com>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/02/22 19:15:20 by dpoveda-          #+#    #+#              #
#    Updated: 2022/02/25 19:58:57 by dpoveda-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

# wait until database is ready
while ! mariadb -h$MYSQL_HOST -u$WP_DB_USER -p$WP_DB_PASSWORD $WP_DB_NAME --silent; do
	echo "[INFO] waiting for database..."
	sleep 1;
done

# check for adminer
if [ ! -f "/var/www/html/adminer.php" ]; then
	# adminer
	echo "[INFO] installing adminer..."
	wget -O "/var/www/html/adminer.php" "https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql.php"
fi

# check for phpmyadmin
if [ ! -d "/var/www/html/phpmyadmin" ]; then
	echo "[INFO] installing phpmyadmin..."
	wget "http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz"
	tar zxvf "phpMyAdmin-5.0.2-all-languages.tar.gz"
	rm "phpMyAdmin-5.0.2-all-languages.tar.gz"
	mv "phpMyAdmin-5.0.2-all-languages" "/var/www/html/phpmyadmin"
	cp "/var/www/html/phpmyadmin/config.sample.inc.php" "/var/www/html/phpmyadmin/config.inc.php"
	sed -i "s|localhost|$MYSQL_HOST|g" /var/www/html/phpmyadmin/config.inc.php
fi

# check if website already created
if [ ! -f "/var/www/html/index.html" ]; then
	echo "[INFO] installing wordpress..."

	# wp-cli
	wp core download --allow-root
	wp config create --dbname=$WP_DB_NAME --dbuser=$WP_DB_USER --dbpass=$WP_DB_PASSWORD \
		--dbhost=$MYSQL_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
	wp core install --url=$DOMAIN_NAME/wordpress --title=$WP_TITLE --admin_user=$WP_ADMIN_USER \
		--admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
	wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASSWORD --allow-root
	wp theme install ryu --activate --allow-root

	# redis
    sed -i "40i define('WP_REDIS_HOST', '$REDIS_HOST');" wp-config.php
    sed -i "41i define('WP_REDIS_PORT', 6379);" wp-config.php
    sed -i "42i define('WP_REDIS_PASSWORD', '$REDIS_PWD');" wp-config.php
    sed -i "43i define('WP_REDIS_TIMEOUT', 1);" wp-config.php
    sed -i "44i define('WP_REDIS_READ_TIMEOUT', 1);" wp-config.php
    sed -i "45i define('WP_REDIS_DATABASE', 0);\n" wp-config.php
	sed -i "46i define('WP_CACHE', true);" wp-config.php
	sed -i "47i define('WP_CACHE_KEY_SALT', 'dpoveda-.42.fr');" wp-config.php
	# install redir plugin to wordpress
    wp plugin install redis-cache --activate --allow-root

	# update plugins
    wp plugin update --all --allow-root

	echo "[INFO] wordpress installation finished"
	touch /var/www/html/$WP_FILE_ONINSTALL
fi

# static website
echo "[INFO] copying static site..."
mv /tmp/static-web/* /var/www/html/

# enable redis
wp redis enable --allow-root

echo "[INFO] starting php-fpm..."
mkdir -p /var/run/php-fpm7
#php-fpm7 -R --nodaemonize
php-fpm7 --nodaemonize
