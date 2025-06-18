DOCKER_COMPOSE_FILE := ./srcs/docker-compose.yml
DATA_DIR := /home/jingwu/data
DB_DATA_DIR := $(DATA_DIR)/db_data
WP_DATA_DIR := $(DATA_DIR)/wp_data
REDIS_DATA_DIR := $(DATA_DIR)/redis_data
DOCKER_COMPOSE := docker compose -f $(DOCKER_COMPOSE_FILE)

all: up

up:
	@if [ ! -d $(DB_DATA_DIR) ]; then \
		mkdir -p $(DB_DATA_DIR); \
		echo "Created $(DB_DATA_DIR)"; \
	fi

	@if [ ! -d $(WP_DATA_DIR) ]; then \
		mkdir -p $(WP_DATA_DIR); \
		echo "Created $(WP_DATA_DIR)"; \
	fi

	@if [ ! -d $(REDIS_DATA_DIR) ]; then \
		mkdir -p $(REDIS_DATA_DIR); \
		echo "Created $(REDIS_DATA_DIR)"; \
	fi

# "-d" detached mode(runs in backgroud)
# "--build" rebuild containers
	@$(DOCKER_COMPOSE) up --build -d

# "-v"/"--volumes" remove volumes too
# "--rmi all" remove images too
down:
	@$(DOCKER_COMPOSE) down

ps:
	@(DOCKER_COMPOSE) ps

logs:
	@(DOCKER_COMPOSE) logs

# clean: down
# 	@if [ -d $(DATA_DIR) ]; then \
# 		echo "Removing $(DATA_DIR)..."; \
# 		sudo rm -fr $(DATA_DIR); \
# 	fi

clean:
	@echo "Stopping and removing containers..."
	@$(DOCKER_COMPOSE) down

	@echo "Removing data directories in $(DATA_DIR)..."
	@if [ -d $(DATA_DIR) ]; then \
		sudo rm -rf $(DATA_DIR); \
		echo "Removed $(DATA_DIR)"; \
	else \
		echo "$(DATA_DIR) does not exist. Skipping removal."; \
	fi

fclean: clean
	@$(DOCKER_COMPOSE) down -v --rmi all
	@echo "Docker images, volumes, and networkds have been removed."

re: down up

help:
	@echo "Support Commannds:"
	@echo "  all         Starts the services defined in your docker-compose.yml (same as "make up")"
	@echo "  up          Starts the services defined in your docker-compose.yml"
	@echo "  down        Stops and removes containers"
	@echo "  ps          Shows the status of docker containers"
	@echo "  logs        Lists containers created by the current Compose project"
	@echo "  clean       Stops and removes docker containsers; and removes data directories"
	@echo "  fclean      Stops and removes containers, images, volumes and networks"
	@echo "  re          Rebuilds docker images and restarts docker containers"
	@echo "  help        Displays the help message"

.PHONY: all up down ps logs clean fclean re help
