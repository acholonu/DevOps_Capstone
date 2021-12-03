#!/usr/bin/env bash

# Create Docker Image for Postgres Database Service
# ------------------------------------------------
# Args:
# -----
# 
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

# Run DAGSTER Postgres Database Image
# -----------------------------------
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
docker run --rm -d --name dagster-db-ctnr -p 5432:5432 \
    -v postgres_data:/var/lib/postgresql/data \
    -v postgres_config:/etc/postgresql \
    --network postgres_network \
    dagster-postgres-db:latest

# Here is where I left off: https://docs.docker.com/language/python/develop/#:~:text=Now%20we%20can%20run,%24
