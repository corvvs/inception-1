# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    run.sh                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dpoveda- <me@izenynn.com>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/02/25 20:49:03 by dpoveda-          #+#    #+#              #
#    Updated: 2022/02/25 20:55:24 by dpoveda-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

# check for static website
if [ ! -f "/var/www/html/index.html" ]; then
	echo "[INFO] copying static website..."
	mv /tmp/website/* /var/www/html/
fi
