#!/usr/bin/env bash

# Create Docker Image for Postgres Database Service
# ------------------------------------------------
# Args:
# -----
# $1 = container name
#
# How to run
# ----------
# Assumes you are in the dagster database folder
# ./test_db_image.sh db-test-ctnr

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
echo -e "Arguments Received: [$1] "

# Log into Container
# ------------------
# log into container and print out usernames and privileges
docker exec -ti db-test-ctnr bash

# Other commands to run in bash
psql -U postgres

## list connection info
# --
#\conninfo

# list users and priviledges
\du+

# list databases
\l

# quit out of psql
\q

# To exit the containee
exit