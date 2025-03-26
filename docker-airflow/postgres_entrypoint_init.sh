#!/usr/bin/env bash

TRY_LOOP="30"
INDUSTRIAL_DB=dwh
POSTGRES_CONN=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@postgres:5432/${POSTGRES_DB}

trying_to_create_database() {
  local name="$1" host="$2" port="$3"
  local j=0
  while ! psql ${POSTGRES_CONN} -a -c "create database ${INDUSTRIAL_DB};" >/dev/null 2>&1 < /dev/null; do
    j=$((j+1))
    if [ $j -ge $TRY_LOOP ]; then
      echo >&2 "$(date) - $host:$port still not reachable, giving up"
      exit 1
    fi
    echo "$(date) - waiting for $name... $j/$TRY_LOOP"
    sleep 10
  done
}

psql ${POSTGRES_CONN} -a -c "drop database if exists ${INDUSTRIAL_DB};"
trying_to_create_database "Postgres" "postgres" "5432"

POSTGRES_CONN=postgresql://${POSTGRES_USER=}:${POSTGRES_PASSWORD}@postgres:5432/${INDUSTRIAL_DB}

find /ddl/ -type f | xargs -L1 psql ${POSTGRES_CONN} -f
