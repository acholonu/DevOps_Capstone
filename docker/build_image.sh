# Create Docker Image for Dagster Service
# ------------------------------------------
# Args:
# -----
# $1 = image tag version (e.g., v1.0)
# $2 = Use a cache path
#
# How to run
# ----------
# ./../docker/build_image.sh v1.0 false

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

# Build Image
# -----------
# Run in app folder. So change directory. The Dockerfile should be in the app folder
# The period (.) at the end is the context
if $2 = true 
then
    docker build --cache-from=dagster_app --tag dagster_app:$1 .
else
    docker build --tag dagster_app:$1 .
fi 

# Add latest tag to built image
# -----------------------------
docker tag dagster_app:$1 dagster_app:latest

# List images
# -----------
docker images

# Scan image
# ----------
# Can only use if uploaded
#docker scan dagster_app:latest