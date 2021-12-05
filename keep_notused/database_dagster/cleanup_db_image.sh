#!/bin/bash

# Cleanup
# -------
# Args:
# -----
# $1 = image tag version (e.g., v0.1.0)
#
# How to run
# ----------
# ./cleanup_db_image.sh v1.0

# Set Script Options
# ---------------------------
# Reference: https://intoli.com/blog/exit-on-errors-in-bash-scripts/

# exit when any command fails
set -e
# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT

# List Images and Containers
# --------------------------
echo "arguments: image_tag: $1 container"

docker ps -a
docker rmi dagster-postgres-db:$1 # remove image
docker rmi dagster-postgres-db:latest

docker images