# Overview

This file describes how the docker scripts and files work together.

## Scripts

## DockerFiles

## Deployment

- There are three spaces where I am deploying.  I am deploying the dagster container to Lambda and my ECR repository.
- I am deploying the flask application to my personal DockerHub repository named learning.
- Finally, from the docker hub, I am deploying this container to my kubernetes cluster. (May later change to ECS, but not sure).
