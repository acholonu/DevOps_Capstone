#!/bin/bash

# Cleanup
# -------
# Args:
# -----
# $1 = image tag version (e.g., v0.1.0)
# $2 = name of the container. If image is already stopped, pass in NONE as the value
#
# How to run
# ----------
# ./cleanup_docker_image.sh v0.1.0 NONE

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
echo "@@@Arguments: image_tag: $1 container name: $2"
docker images
docker ps -all

if $2 != "NONE"
then
    docker stop $2 # Stop Container
    docker rm $2 # Remove container
fi
docker rmi dagster-app:$1 # remove image