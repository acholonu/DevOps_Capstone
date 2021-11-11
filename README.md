# Overview

The goal of this project is to deploy a microsoft service onto a kubernetes cluster using best practices in DevOps.  I will deploy the dagster hello world microservice tutorial.

## Tools Use in This Project

- [CircleCI](app.circleci.com)
- [AWS Kubernetes Service](https://www.eksworkshop.com/010_introduction/)
- [GitHub](https://github.com/acholonu/DevOps_Capstone)
- [Ansible](ttps://docs.ansible.com/ansible/latest/cli/ansible-playbook.html)
- [Prometheus Monitoring](#test)

## Files

- Makefile: mainly use so I can test the docker container configuration before implementing within the CircleCI framework.  Will test install pyenv or poetry inside of the container versus venv.
- Dockerfile: Creates the image that generates the container that will run the dagster app.
