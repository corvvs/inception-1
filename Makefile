# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dpoveda- <me@izenynn.com>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/02/21 18:47:50 by dpoveda-          #+#    #+#              #
#    Updated: 2022/02/25 22:22:45 by dpoveda-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# YOUR HOME DIR
#HOME=/tmp
HOME=/home/rabi/data
#HOME=/Users/dpoveda-/data

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
	ENV_FILE = ./srcs/.env
else
	ENV_FILE = ./srcs/.env.linux
endif

VOLUMES_PATH = $(HOME)/inception_data
VOLUMES_DIR = db_data web_data

VOLUMES = $(addprefix $(VOLUMES_PATH)/, $(VOLUMES_DIR))

all: stop load

load: | $(VOLUMES)
	#docker-compose -f ./srcs/docker-compose.yml up -d --build
	docker-compose -f ./srcs/docker-compose.yml --env-file $(ENV_FILE) up -d --build

debug: | $(VOLUMES)
	#docker-compose -f ./srcs/docker-compose.yml up --build
	docker-compose -f ./srcs/docker-compose.yml --env-file $(ENV_FILE) up --build

$(VOLUMES):
	mkdir -p $(VOLUMES)

stop:
	#docker-compose -f srcs/docker-compose.yml down
	docker-compose -f srcs/docker-compose.yml --env-file $(ENV_FILE) down

clean: stop
	docker volume rm $(addprefix srcs_, $(VOLUMES_DIR)) -f
	docker volume prune -f
	rm -rf $(VOLUMES_PATH) || rm -rf $(VOLUMES)

prune: clean
	docker system prune -af

re: prune load

.PHONY: all load debug stop clean prune re
