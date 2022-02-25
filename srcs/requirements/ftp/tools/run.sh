# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    run.sh                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dpoveda- <me@izenynn.com>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/02/25 01:02:44 by dpoveda-          #+#    #+#              #
#    Updated: 2022/02/25 01:50:11 by dpoveda-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

mv /tmp/vsftpd.conf /etc/vsftpd/vsftpd.conf

adduser $FTP_USER --disabled-password
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

echo $FTP_USER >> /etc/vsftpd.userlist

mkdir -p /var/www/html
chown -R $FTP_USER:$FTP_USER /var/www/html

echo "[INFO] started FTP server"
vsftpd /etc/vsftpd/vsftpd.conf
