# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    run.sh                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dpoveda- <me@izenynn.com>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/02/25 14:52:07 by dpoveda-          #+#    #+#              #
#    Updated: 2022/02/25 16:03:57 by dpoveda-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

if [ ! -f "/etc/redis.conf.old" ]; then
	mv /etc/redis.conf /etc/redis.conf.old
	mv /tmp/redis.conf /etc/redis.conf
fi

#redis-server --protected-mode no
redis-server /etc/redis.conf --protected-mode no
