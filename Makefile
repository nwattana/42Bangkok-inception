NAME=inception
DB_VOLUMNE_PATH=/home/nwattana/data/db
WP_VOLUMNE_PATH=/home/nwattana/data/wp
SCRIPTS_PATH=./srcs/docker-compose.yml 

all: create_dir up
	
down:
	-docker compose -f $(SCRIPTS_PATH) down

up:
	docker compose -f $(SCRIPTS_PATH) up -d

build:		
	docker compose -f $(SCRIPTS_PATH) build 

create_dir:
	mkdir -p $(DB_VOLUMNE_PATH) $(WP_VOLUMNE_PATH)

rm-container:
	@if [ ! -z "$$(docker ps -qa)" ]; then \
		docker stop $$(docker ps -qa); \
		docker rm $$(docker ps -qa); \
	fi
	@echo "STOP && RM container"

rm-image:
	@if [ ! -z "$$(docker images -qa)" ]; then \
		docker rmi -f $$(docker images -qa);\
	fi
	@echo "REMOVE image"

rm-volume:
	@if [ ! -z "$$(docker volume ls -q)" ]; then \
		docker volume rm $$(docker volume ls -q);\
	fi
	@echo "REMOVE volume"

rm-network:
	@if [ ! -z "$$(docker network ls -q)" ]; then \
		docker rmi -f $$(docker network ls -q);\
	fi 2> /dev/null
	@echo "REMOVE network"

clean: rm-container rm-image rm-volume rm-network

fclean: clean
	@sudo rm -rf $(DB_VOLUMNE_PATH) $(WP_VOLUMNE_PATH)
	@docker system prune --all -f
	@docker volume prune -f

rmpersist:
	-docker volume rm $(docker volume ls -q)
	sudo rm -rf  $(DB_VOLUMNE_PATH) $(WP_VOLUMNE_PATH) && echo "Clean Persist data"

re: fclean all

rm-test:
	docker stop $$(docker ps -a | grep test- | awk '{print $$NF}')

# https://en.wikipedia.org/wiki/Transport_Layer_Security
# insecure ใส่มากัน error self-sign
# more info add iv
tls-check-success:
	-@curl -I --insecure --tlsv1.3 --tls-max 1.3 https://nwattana.42.fr

.PHONY: all clean fclean re create_dir

