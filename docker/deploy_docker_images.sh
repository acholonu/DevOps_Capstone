#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub
# Resource: https://docs.docker.com/docker-hub/repos/#:~:text=To%20push%20an%20image%20to,docs%2Fbase%3Atesting%20).
# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
#dockerpath=<your docker ID/<repository>
dockerpath=$username/learning

# Step 2:  
# Authenticate & tag
# I have an environment variable $username and $password so that I don't save in github
docker login --username $username --password $password

# I have a token on my machine that allows me to push directly to my repository

echo "Respository link: Docker ID and Image: $dockerpath"

# Step 3:
# Push image to a docker repository
# push to repository: docker push <hub-user>/<repo-name>:<tag>
# QUESTION:  Will it push everything with the latest tag?
docker push $dockerpath:latest

# Interesting command: docker info