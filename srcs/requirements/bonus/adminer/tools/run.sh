# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    run.sh                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dpoveda- <me@izenynn.com>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/02/25 20:41:38 by dpoveda-          #+#    #+#              #
#    Updated: 2022/02/25 20:41:57 by dpoveda-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

# check for adminer
if [ ! -f "/var/www/html/adminer.php" ]; then
	# adminer
	echo "[INFO] installing adminer..."
	wget -O "/var/www/html/adminer.php" "https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql.php"
fi
