#!/bin/bash

# Notes
# -----
# This script is supposed be stored in the DB.Dockerfile image
#
# More info:
# ----------
# Reference: https://hub.docker.com/_/postgres#:~:text=POSTGRES_USER%2C%20and%20POSTGRES_DB.-,Initialization%20scripts,-If%20you%20would
# If you would like to do additional initialization in an image derived from this one, add one or more *.sql, 
# *.sql.gz, or *.sh scripts under /docker-entrypoint-initdb.d (creating the directory if necessary). After the 
# entrypoint calls initdb to create the default postgres user and database, it will run any *.sql files, run 
# any executable *.sh scripts, and source any non-executable *.sh scripts found in that directory to do further 
# initialization before starting the service.
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER $DAGSTER_POSTGRES_USER WITH NOSUPERUSER NOCREATEDB NOCREATEROLE LOGIN PASSWORD $DAGSTER_POSTGRES_PASSWORD;
    GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO $DAGSTER_POSTGRES_USER;
EOSQL