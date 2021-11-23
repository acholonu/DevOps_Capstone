# Create Docker Image for Dagster Service
# ------------------------------------------
# Args:
# -----
# $1 = image tag version (e.g., v0.1.0)
# $2 = name of the container
# $3 = What should be grepped
#
# How to run
# ----------
# ./build_dagster_image.sh v0.1.0 dagstr-app-{workflow_id} Hello


# Build Image
# -----------
docker build -f Dagster.Dockerfile --tag dagster_app:$1 ../dagster

# Add latest tag to built image
# -----------------------------
docker tag dagster_app:$1 dagster_app:latest

# List images
# -----------
docker images

# Run a Container in detach mode
# ------------------------------
# The name of the container is passed through the second argument ($2).
docker run -d -p 5000:5000 --name $2 dagster_app

# List all processes running
# --------------------------
docker ps --all

# Test Container works correctly
# ------------------------------
URL = localhost:5000 #FIX: Look at smoke test, return success
echo "URL = $URL"
if curl $URL | grep 'Hello World'
then
    echo "SUCCESS: Connected to backend EC2 instance: $URL"
else
    echo "FAILURE: Failed to connect to backend EC2 instance: $URL"
    return 1
fi

# Cleanup
# -------
docker stop $2 # Stop Container
docker rm $2 # remove container
docker rmi dagster_app:$1 # remove image

return 0
