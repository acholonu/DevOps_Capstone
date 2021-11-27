# Test Dagster Image
# ------------------
# Args:
# -----
# $1 = name of the container
# $2 = What should be grepped
#
# How to run
# ----------
# ./../docker/test_image.sh dagster-app-{workflow_id} Hello
# or
# ./../docker/test_image.sh dagster-app-test Hello

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

# Run a Container in detach mode
# ------------------------------
# The name of the container is passed through the second argument ($2).
docker run -d --env-file .env -p 3000:3000 --name $1 dagster_app

# List all processes running
# --------------------------
docker ps --all

# Test Container works correctly
# ------------------------------
#URL=localhost:3000 #FIX: Look at smoke test, return success
URL=0.0.0.0:3000
echo "URL = $URL"
if curl $URL | grep $2
then
    echo "SUCCESS: Connected to Dagster UI: $URL"
    #docker stop $1
    exit 0
else
    echo "FAILURE: Failed to connect to Dagster UI: $URL"
    #docker stop $1
    exit 1
fi