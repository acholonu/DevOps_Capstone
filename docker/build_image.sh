# Create Docker Image for Dagster Service
# ------------------------------------------
# Args:
# -----
# $1 = image tag version (e.g., v0.1.0)
#
# How to run
# ----------
# ./../docker/build_image.sh v0.1.0
# or
# ./../docker/build_image.sh v0.1.0

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
echo "Arguments Received: [\n$1] "

# Build Image
# -----------
# Run in app folder. So change directory. The Dockerfile should be in the app folder
docker build --tag dagster_app:$1 .

# Add latest tag to built image
# -----------------------------
docker tag dagster_app:$1 dagster_app:latest

# List images
# -----------
docker images
