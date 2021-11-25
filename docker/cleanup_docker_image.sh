# Cleanup
# -------
# Args:
# -----
# $1 = image tag version (e.g., v0.1.0)
# $2 = name of the container. If image is already stopped, pass in NONE as the value
#
# How to run
# ----------
# ./cleanup_docker_image.sh v0.1.0 dagstr-app-{workflow_id}

echo "@@@Arguments: image_tag: $1 container name: $2"
docker images
docker ps -all

if $2 != "NONE"
then
    docker stop $2 # Stop Container
    docker rm $2 # remove container
fi
docker rmi web_flask_app:$1 # remove image

return 0