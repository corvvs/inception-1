# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    run.sh                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dpoveda- <me@izenynn.com>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/02/25 01:02:44 by dpoveda-          #+#    #+#              #
#    Updated: 2022/02/25 22:41:52 by dpoveda-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

if [ ! -f /etc/vsftpd/vsftpd.old ]; then
	mv /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.old
	mv /tmp/vsftpd.conf /etc/vsftpd/vsftpd.conf

	adduser $FTP_USER --disabled-password
	echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

	echo $FTP_USER >> /etc/vsftpd.userlist

	# wait for wordpress to finish installation
	#while [ ! -f "/var/www/html/$WP_FILE_ONINSTALL" ]; do
	while [ ! -f "/var/www/html/$WP_FILE_ONINSTALL" ] || [ ! -f "/var/www/html/index.html" ] || [ ! -f "/var/www/html/adminer.php" ] || [ ! -d "/var/www/html/phpmyadmin" ]; do
		echo "[INFO] waiting for all installation to finish..."
		sleep 5
	done

	mkdir -p /var/www/html
	chown -R $FTP_USER:$FTP_USER /var/www/html

	echo "[INFO] started FTP server"
fi

chown -R $FTP_USER:$FTP_USER /var/www/html

vsftpd /etc/vsftpd/vsftpd.conf
