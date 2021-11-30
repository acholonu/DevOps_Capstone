# Create Docker Image for Postgres Database Service
# ------------------------------------------------
# Args:
# -----
# $1 = true if you want Create Volumes
# $2 = Use a cache path
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

# Here is where I left off: https://docs.docker.com/language/python/develop/#:~:text=Now%20we%20can%20run,%24
