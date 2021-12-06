docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD docker.io
docker-compose push --ignore-push-failures