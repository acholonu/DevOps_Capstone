# Overview

The goal of this project is to deploy a microsoft service onto a kubernetes cluster using best practices in DevOps.  I will deploy the dagster hello world microservice tutorial.

## Simple Micorservice

### Backend

The backend consist of two part: A service that polls a postgres database to see if any schema changes have happened. The second service processes schema changes using the orchestration tool called Dagster.  

### Frontend

Simple Flask app that prints backend results to screen.

## Tools Used in This Project

- [CircleCI](app.circleci.com)
- [AWS Kubernetes Service](https://www.eksworkshop.com/010_introduction/)
- [GitHub](https://github.com/acholonu/DevOps_Capstone)
- [Ansible](ttps://docs.ansible.com/ansible/latest/cli/ansible-playbook.html)
- [Prometheus Monitoring](#test)
- [EKS Tutorial](https://www.eksworkshop.com/010_introduction/)
- [EKS Tutorial Video](https://www.youtube.com/watch?v=-zmUxsrYw2I&t=7s)
- [Amazon Secrets Manager](https://aws.amazon.com/secrets-manager/)
- [Elastic Container Repository - ECR](https://aws.amazon.com/ecr/) I will use this instead of DockerHub, Maybe?

## Files

- Makefile: mainly use so I can test the docker container configuration before implementing within the CircleCI framework.  Will test install pyenv or poetry inside of the container versus venv.
- Dockerfile: Creates the image that generates the container that will run the dagster app.

## References

- [Mutliple Dockerfiles in Project](https://stackoverflow.com/questions/27409761/docker-multiple-dockerfiles-in-project)