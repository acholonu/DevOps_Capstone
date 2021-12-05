#!/usr/bin/env bash

# Create Docker Image for Postgres Database Service
# ------------------------------------------------
# Args:
# -----
# $1 = image tag version (e.g., v1.0)
# $2 = true if you want Create Volumes
# $3 = true if you want to build from a cache path
#
# How to run
# ----------
# Assumes you are in the database_dagster folder
# ./build_db_image.sh v1.0 false false

# Set Script Options
# ---------------------------
# Reference: https://intoli.com/blog/exit-on-errors-in-bash-scripts/

# exit when any command fails
set -e
# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT

# Print Arguments
# ---------------
echo -e "Arguments Received: [\n$1, $2\n] "

# Create Volumes
# --------------
# To support persistance of the data, we create two volumes: 1) to save postgres data
# and the other to save the postgres configurations.

if $2 = true
then
    echo "Creating Volumes"
    docker volume create postgres_data
    docker volume create postgres_config
    docker network create postgres_network
fi

# Build Dagster Postgres DB Image
# -------------------------------
if $3 = true
then
    echo "Creating from Cache"
    docker build --cache-from=dagster-postgres-db --tag dagster-postgres-db:$1 .
else
    docker build --tag dagster-postgres-db:$1 .
fi 

# Add latest tag to built image
# -----------------------------
docker tag dagster-postgres-db:$1 dagster-postgres-db:latest