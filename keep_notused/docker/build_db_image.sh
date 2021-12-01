#!/usr/bin/env bash

# Create Docker Image for Postgres Database Service
# ------------------------------------------------
# Args:
# -----
# $1 = true if you want Create Volumes
#
# How to run
# ----------
# Assumes you are in the dagster folder
# ./../docker/build_db_image.sh false

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
if $1 = true 
then
    docker volume create postgres_data
    docker volume create postgres_config
    docker network create postgres_network
fi

# Run Postgres Database Image
# ------------------------------
# Note, I already pulled the docker image to my local image repository
# I used the command: `docker pull postgres`.  It is the official postgres
# container. url: https://hub.docker.com/_/postgres
#
# Side note:
# the \ (i.e. backslash) at the end says ignore the next character. In this
# case the next character was \n (i.e. new line).  However, I was running into an error earlier
# where the following command was not working.  The issue was that I had a space
# and then a \n. So the command ignore the space and not the \n.  So the overall
# command would fail.  I had to remove the space. 
docker run --rm -d --name dagster_db_ctnr -p 5432:5432 \
    -v postgres_data:/var/lib/postgresql/data \
    -v postgres_config:/etc/postgresql \
    --network postgres_network \
    -e POSTGRES_PASSWORD=$POSTGRES_SUPER_USER_PASSWORD \
    -e POSTGRES_USER=$POSTGRES_SUPER_USER \
    -e POSTGRES_DB=$POSTGRES_DATABASE \
    postgres

# Note -e says this is an environment variable

# Here is where I left off: https://docs.docker.com/language/python/develop/#:~:text=Now%20we%20can%20run,%24
