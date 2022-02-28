# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    run.sh                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dpoveda- <me@izenynn.com>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/02/25 21:06:45 by dpoveda-          #+#    #+#              #
#    Updated: 2022/02/28 17:39:00 by dpoveda-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

# copy config files
mv /tmp/named.conf /etc/bind/named.conf
mv /tmp/dpoveda.42.fr.zone /etc/bind/dpoveda.42.fr.zone

# start dns service
named -c /etc/bind/named.conf -g -u named
