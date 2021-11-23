# Create and Test Docker Image for Frontend Flask App
# ---------------------------------------------------
# Args:
# -----
# $1 = image tag version (e.g., v0.1.0)
# $2 = name of the container
# $3 = What should be grepped
#
# How to run
# ----------
# ./build_web_app_image.sh v0.1.0 web-app-{workflow_id} Hello


# Build Image
# -----------
docker build --tag web_flask_app:$1 ../frontend_web_app

# Add latest tag to built image
# -----------------------------
docker tag web_flask_app:$1 web_flask_app:latest

# List images
# -----------
docker images

# Run a Container in detach mode
# ------------------------------
docker run -d -p 5000:5000 --name $2 web_flask_app

# List all processes running
# --------------------------
docker ps --all

# Test Container works correctly
# ------------------------------
URL = localhost:5000 #FIX: Look at smoke test, return success
echo "URL = $URL"
if curl $URL | grep 'Hello World'
then
    echo "SUCCESS: Connected to Docker host instance: $URL"
else
    echo "FAILURE: Failed to connect to backend EC2 instance: $URL"
    return 1
fi

# Cleanup
# -------
docker stop $2 # Stop Container
docker rm $2 # remove container
docker rmi web_flask_app:$1 # remove image

return 0
    