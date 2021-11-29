# Test Dagster Image
# ------------------
# Args:
# -----
# $1 = name of the container
# $2 = What should be grepped
# $3 = true if providing an environemnt variable file
#
# How to run
# ----------
# ./../docker/test_image.sh dagster-app-{CIRCLE_WORKFLOW_ID} Hello false
# or
# ./../docker/test_image.sh dagster-app-test Hello true

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
echo -e "Arguments Received: [\n$1,\n$2,\n$3]"

# Run a Container in detach mode
# ------------------------------
# The name of the container ($1).
if $3 = true 
then
    docker run -d --env-file .env -p 3000:3000 --name $1 dagster-app
else
    # Environment variables should be made available through CircleCI
    #docker run -d -p 3000:3000 -e POSTGRES_DATABASE -e POSTGRES_HOST -e POSTGRES_PASSWORD -e POSTGRES_USER --name $1 dagster_app
    docker run -d -p 3000:3000 --name $1 dagster-app
fi

# List all processes running
# --------------------------
docker ps --all

# Test Container works correctly
# ------------------------------
URL=localhost:3000
#URL=0.0.0.0:3000
echo "URL = $URL"

# Check if can connect
if curl $URL
then
    echo "SUCCESS(+): Connected to Dagster UI\n"
else
    echo "FAILURE(-): Failed to connect to Dagster"
    docker stop $1
    exit 1
fi

# Check if it found relevant word.
if curl $URL | grep $2
then
    echo "SUCCESS(++): found $2 in document: $URL\n"
    docker stop $1
    exit 0
else
    echo "FAILURE(--): Failed to find $2 in document: $URL"
    docker stop $1
    exit 1
fi