# Overview

The goal of this project is to deploy a microsoft service onto a kubernetes cluster using best practices in DevOps.  I will deploy the dagster hello world microservice tutorial.

## Simple Micorservice

- Flask app that triggers dagster container to execute a workflow.  The result of that workflow is then printed to the screen.
- The flask app has a simple button that says trigger.  Once triggered the dagster process goes off (the frontend shows processing).  And when done, shows the output of the dagster process

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
- [Postgres Image](https://hub.docker.com/_/postgres)

## Files

- Makefile: mainly use so I can test the docker container configuration before implementing within the CircleCI framework.  Will test install pyenv or poetry inside of the container versus venv.
- Dockerfile: Creates the image that generates the container that will run the dagster app.

## References

- [Mutliple Dockerfiles in Project](https://stackoverflow.com/questions/27409761/docker-multiple-dockerfiles-in-project)
- [Dagster Example](https://github.com/dagster-io/dagster/tree/master/examples/hacker_news)
- [Run CircleCI on Local Machine](https://circleci.com/docs/2.0/local-cli/#processing-a-config)
- [How to Check Linux Version](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)
- [Creating VirtualEnvs with venv](https://docs.python.org/3/library/venv.html)
- [Python Application with CircleCi](https://circleci.com/docs/2.0/language-python/)
- [Udacity Capstone Examples](https://knowledge.udacity.com/questions/55383)
- [CircleCI Kubernetes](https://circleci.com/developer/orbs/orb/circleci/aws-eks#usage-create-eks-cluster)
- [Docker and Postgres DB](https://dev.to/andre347/how-to-easily-create-a-postgres-database-in-docker-4moj)

## Notes

- To check path of poetry environment use the command `poetry env info`.  My path is currently located at /~/Library/Caches/pypoetry/virtualenvs/capstone-XWfwnle5-py3.10.  So to reactivate this virtual environment I would use:
  - `source ~/Library/Caches/pypoetry/virtualenvs/capstone-XWfwnle5-py3.10 activate`
- Ran into a warning in the construction of my Dockerfile (i.e., Dockerfile:10 DL4006 warning: Set the SHELL option -o pipefail before RUN with a pipe in it).  Here are the two URLs that helped me fixed these errors.
  - <https://githubmemory.com/repo/hadolint/hadolint/issues/724>
  - <https://github.com/hadolint/hadolint/wiki/DL4006>
