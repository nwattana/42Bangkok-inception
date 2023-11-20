NAME=inception
DB_VOLUMNE_PATH=/home/nwattana/data/db
WP_VOLUMNE_PATH=/home/nwattana/data/wp

all:
	mkdir -p $(DB_VOLUMNE_PATH) $(WP_VOLUMNE_PATH)
	docker compose -f ./srcs/docker-compose.yml up -d

clean:
	@docker stop $$(docker ps -qa);\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls -q);\
	docker network rm $$(docker network ls -aq | grep -v local);\

fclean:
	@echo "Make fcklen"

re:
	@echo "Make re"

rm-test:
	docker stop $$(docker ps -a | grep test- | awk '{print $$NF}')

.PHONY: all clean fclean re

