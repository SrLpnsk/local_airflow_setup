## Local Setup of Airflow and PostgreSQL with Docker

### Prerequisites

- The Docker Desktop should be installed and running

### Description
- The local Docker setup is adapted from the puckel/docker-airflow repository.
- The implementation has been customized from my personal repository to meet the task's requirements.
- In summary, the environment consists of:
  1. Building the Airflow image
     -  Based on a `Dockerfile` that wraps `airflow.cfg` (the configuration file) and `entrypoint.sh` (the image's entry point).
  2. Running five Docker containers via `docker-compose.yml`:
     - `redis`: Uses the official Redis image.
     - `posgres`: Serves as both the Airflow metadata database and the task-specific data warehouse.
     - `webserver`, `scheduler`, `worker`: Derived from the custom-built Airflow image.
  3. Mounting local folders:
     - The `dags`, `ddl`, `input` and `output`folders are configured as mounted volumes for seamless interaction between the local and Dockerized environments.
  4. Database initialization:
     - The script `postgres_entrypoint_init.sh` creates the data warehouse DB and all the objects, defined in the `/ddl` folder
### Initialization and management
The major actions are wrapped into make commands:
- To initialize the environment, run `make` to build the image, start the docker containers, create the data warehouse
DB and create all the DDL objects:
```bash
$ make
```
- To pause the local environment (all the data will remain), run
```bash
$ make pause
```
- To restart the local airflow 
```bash
$ make restart
```
- To stop the local airflow and remove all the containers and images, run
```bash
$ make rollback
```
- While the local airflow machine is already built, however, local data warehouse is outdated, run 
```bash
$ make rebuild-db
```
