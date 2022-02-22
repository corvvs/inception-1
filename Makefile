# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dpoveda- <me@izenynn.com>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/02/21 18:47:50 by dpoveda-          #+#    #+#              #
#    Updated: 2022/02/22 15:45:32 by dpoveda-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

VOLUMES_PATH = ${HOME}/inception_data
VOLUMES_DIR = db wordpress

VOLUMES = $(addprefix $(VOLUMES_PATH)/, $(VOLUMES_DIR))

all: clean load

load: | $(VOLUMES)
	docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env up -d --build

debug: | $(VOLUMES)
	docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env up --build

$(VOLUMES):
	mkdir -p $(VOLUMES)

stop:
	docker-compose -f srcs/docker-compose.yml --env-file ./srcs/.env down

clean: stop
	docker volume rm srcs_db srcs_wordpress -f
	docker volume prune -f
	rm -rf $(VOLUMES)

prune: clean
	docker system prune -af

re: clean all

.PHONY: all load debug stop clean prune re
