NAME=inception
DB_VOLUMNE_PATH=/home/nwattana/data/db
WP_VOLUMNE_PATH=/home/nwattana/data/wp
SCRIPTS_PATH=./srcs/docker-compose.yml 

all: up
	
down:
	-docker compose -f $(SCRIPTS_PATH) down

up: create_dir
	docker compose -f $(SCRIPTS_PATH) up -d

build:		
	docker compose -f $(SCRIPTS_PATH) build 

create_dir:
	mkdir -p $(DB_VOLUMNE_PATH) $(WP_VOLUMNE_PATH)

clean:
	make down
	if [ ! -z "$$(docker ps -qa)" ]; then \
		docker stop $$(docker ps -qa); \
		docker rm $$(docker ps -qa); \
		docker rmi -f $$(docker images -qa);\
		docker volume rm $$(docker volume ls -q);\
		docker network rm $$(docker network ls -q);\
	fi

fclean: clean
	@sudo rm -rf $(DB_VOLUMNE_PATH) $(WP_VOLUMNE_PATH)

rmpersist:
	-docker volume rm $(docker volume ls -q)
	sudo rm -rf  $(DB_VOLUMNE_PATH) $(WP_VOLUMNE_PATH)

re: fclean all
	@echo "Make re"

rm-test:
	docker stop $$(docker ps -a | grep test- | awk '{print $$NF}')

# https://en.wikipedia.org/wiki/Transport_Layer_Security
# insecure ใส่มากัน error self-sign
# more info add iv
tls-check-success:
	-@curl -I --insecure --tlsv1.3 --tls-max 1.3 https://nwattana.42.fr

.PHONY: all clean fclean re 

