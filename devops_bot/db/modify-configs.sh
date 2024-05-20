#!/bin/bash
set -Eeo pipefail

PGDATA="/var/lib/postgresql/data"


echo "CREATE DATABASE ${DB_DATABASE}
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TEMPLATE = template0;" >> /tmp/init_db.sql

echo "\c ${DB_DATABASE};" >> /tmp/init_db.sql

echo "CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE phone_numbers (
    id SERIAL PRIMARY KEY,
    phone_number VARCHAR(20) NOT NULL
);" >> /tmp/init_db.sql

echo "CREATE ROLE ${DB_REPL_USER} REPLICATION LOGIN PASSWORD '${DB_REPL_PASSWORD}';" >> /tmp/init_db.sql

psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -a -f /tmp/init_db.sql

pg_ctl -D $PGDATA stop

echo "host    replication     ${DB_REPL_USER}    172.25.0.4/16           scram-sha-256" >> $PGDATA/pg_hba.conf

cat /tmp/postgresql.conf >> $PGDATA/postgresql.conf

pg_ctl -D $PGDATA start
