# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hurabe <hurabe@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/08 22:39:32 by hurabe            #+#    #+#              #
#    Updated: 2025/04/08 22:39:54 by hurabe           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DOCKER_COMPOSE_FILE = requirements/docker-compose.yml
CONTAINER_NAME = ubuntu

up:
	docker compose -f $(DOCKER_COMPOSE_FILE) up -d --build

down:
	docker compose -f $(DOCKER_COMPOSE_FILE) down

exec:
	docker exec -it $(CONTAINER_NAME) bash

restart:
	docker compose -f $(DOCKER_COMPOSE_FILE) restart

re:
	docker compose -f $(DOCKER_COMPOSE_FILE) down
	docker rm -f $(CONTAINER_NAME) my_nginx website 2>/dev/null || true
	docker compose -f $(DOCKER_COMPOSE_FILE) up -d --build

w:
	docker compose -f $(DOCKER_COMPOSE_FILE) up -d --build website

.PHONY: up down exec restart re rm w
