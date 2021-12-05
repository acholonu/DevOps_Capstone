#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub
# Resource: https://docs.docker.com/docker-hub/repos/#:~:text=To%20push%20an%20image%20to,docs%2Fbase%3Atesting%20).
# Assumes that an image is built on local machine, and you have a latest tag.
#
# Args: 
# -----
# $1 = DOCKER_USERNAME
# $2 = DOCKER_ACCESS_TOKEN
# $3 = image name
#
# How to Run
# ----------
# These should be environment variables or retrieved from feature store.
# > ./deploy_docker_image.sh username password  

# Step 1:
# Create dockerpath
#dockerpath=<your docker ID/<repository>
dockerpath=$1/learning/$3

# Step 2:  
# Authenticate & tag
# I have an environment variable $username and $password so that I don't save in github
docker login --username $1 --password $2

# I have a token on my machine that allows me to push directly to my repository

echo "Respository link: Docker ID and Image: $dockerpath"

# Step 3:
# Push image to a docker repository
# push to repository: docker push <hub-user>/<repo-name>:<tag>
# QUESTION:  Will it push everything with the latest tag?
docker push $dockerpath:latest

# Interesting command: docker info