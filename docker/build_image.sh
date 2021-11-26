# Create Docker Image for Dagster Service
# ------------------------------------------
# Args:
# -----
# $1 = full path to Dockerfile
# $2 = image tag version (e.g., v0.1.0)
# $3 = name of the container
# $4 = What should be grepped
#
# How to run
# ----------
# ./docker/build_image.sh v0.1.0 dagster-app-{workflow_id} Hello

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
echo "Arguments Received: [\n$1,\n$2,\n$3,\n$4] "

# Build Image
# -----------
# Run in app folder. So change directory. The Dockerfile should be in the app folder
docker build --tag dagster_app:$2 .

# Add latest tag to built image
# -----------------------------
docker tag dagster_app:$2 dagster_app:latest

# List images
# -----------
docker images

# Run a Container in detach mode
# ------------------------------
# The name of the container is passed through the second argument ($2).
docker run -d -p 3000:3000 --name $3 dagster_app

# List all processes running
# --------------------------
docker ps --all

# Test Container works correctly
# ------------------------------
URL=localhost:3000 #FIX: Look at smoke test, return success
echo "URL = $URL"
if curl $URL | grep $4
then
    echo "SUCCESS: Connected to Dagster UI: $URL"
    docker stop $3
    return 0
else
    echo "FAILURE: Failed to connect to Dagster UI: $URL"
    docker stop $3
    return 1
fi
