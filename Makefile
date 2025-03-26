.PHONY: make-runnable docker-compose-init build rollback restart pause rebuild-db

IMAGE_NAME = "lpnsk/airflow-with-docker"
DIR := $(shell basename $(shell pwd) | tr '[:upper:]' '[:lower:]')
WEBSERVER = "${DIR}-webserver-1"
WORKER = "${DIR}-worker-1"
POSTGRES = "${DIR}-postgres-1"
FIRSTNAME = "Sergey"
LASTNAME = "Lipinskiy"
EMAIL = "lpnsk11@gmail.com"

make-runnable: docker-compose-init
	docker exec -it $(POSTGRES) bash /postgres_entrypoint_init.sh

docker-compose-init: build
	docker-compose -f docker-compose.yml up -d

build:
	docker build --rm -t $(IMAGE_NAME) -f ./docker-airflow/Dockerfile .

rollback:
	docker-compose -f docker-compose.yml down -v
	docker rmi $(IMAGE_NAME)
	rm -r -f docker-airflow/airflow_volumes/logs
	rm -r -f docker-airflow/airflow_volumes/pgdata
	rm -r -f docker-airflow/airflow_volumes/ssl

restart: pause
	docker-compose -f docker-compose.yml start

pause:
	docker-compose -f docker-compose.yml stop

rebuild-db:
	docker exec -it $(POSTGRES) bash /postgres_entrypoint_init.sh
