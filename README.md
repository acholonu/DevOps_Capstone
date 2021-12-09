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
- [Kubernetes](https://kubernetes.io/docs/home/)
- [GitHub](https://github.com/acholonu/DevOps_Capstone)
- [Ansible](ttps://docs.ansible.com/ansible/latest/cli/ansible-playbook.html)
- [Prometheus Monitoring](#test)
- [EKS Tutorial](https://www.eksworkshop.com/010_introduction/)
- [EKS Tutorial Video](https://www.youtube.com/watch?v=-zmUxsrYw2I&t=7s)
- [Amazon Secrets Manager](https://aws.amazon.com/secrets-manager/)
- [Elastic Container Repository - ECR](https://aws.amazon.com/ecr/) I will use this instead of DockerHub, Maybe?
- [Postgres Image](https://hub.docker.com/_/postgres)
- [Bash Not Equal Operator](https://linuxtect.com/linux-bash-not-equal-ne-operators-tutorial/)
- [Kompose](https://kompose.io/)
  - Convert Docker Compose file to Kubernetes file
- [EKSCTL Minimum IAM Policy](https://eksctl.io/usage/minimum-iam-policies/)
- [EKSCTL Amazon Docs](https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html)

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
- [Database Security](https://docs.oracle.com/cd/B13789_01/network.101/b10773/apdvntro.htm)
- [Creating a Jumpbox](https://aws.amazon.com/premiumsupport/knowledge-center/rds-connect-ec2-bastion-host/)
- [Selenium Testing](https://www.selenium.dev/documentation/)
- [Build A Docker Image in CircleCI](https://circleci.com/blog/how-to-build-a-docker-image-on-circleci-2-0/)

---

## Kubernetes - Container Orchestration in Cloud-Based Production Environments

It is an open source orchestration system for containers developed by Google and open sourced in 2014. Kubernetes is the standard for container orchestration. All major cloud providers support Kubernetes. Kubernetes is also a framework for running distributed systems at "planet scale". Google uses it to run billions of containers a week.

The core operations involved in Kubernetes include creating a Kubernetes Cluster, deploying an application (a containerized microservice) into the cluster, exposing an application ports, scaling an application and updating an application.

Containers are a good way to bundle and run your applications. In a production environment, you need to manage the containers that run the applications and ensure that there is no downtime. For example, if a container goes down, another container needs to start. Wouldn't it be easier if this behavior was handled by a system? That's how Kubernetes comes to the rescue! Kubernetes provides you with a framework to run distributed systems resiliently. It takes care of scaling and failover for your application, provides deployment patterns, and more. For example, Kubernetes can easily manage a canary deployment for your system.

Kubernetes provides you with:

- Service discovery and load balancing Kubernetes can expose a container using the DNS name or using their own IP address. If traffic to a container is high, Kubernetes is able to load balance and distribute the network traffic so that the deployment is stable.
- Storage orchestration Kubernetes allows you to automatically mount a storage system of your choice, such as local storages, public cloud providers, and more.
- Automated rollouts and rollbacks You can describe the desired state for your deployed containers using Kubernetes, and it can change the actual state to the desired state at a controlled rate. For example, you can automate Kubernetes to create new containers for your deployment, remove existing containers and adopt all their resources to the new container.
- Automatic bin packing You provide Kubernetes with a cluster of nodes that it can use to run containerized tasks. You tell Kubernetes how much CPU and memory (RAM) each container needs. Kubernetes can fit containers onto your nodes to make the best use of your resources.
- Self-healing Kubernetes restarts containers that fail, replaces containers, kills containers that don't respond to your user-defined health check, and doesn't advertise them to clients until they are ready to serve.
- Secret and configuration management Kubernetes lets you store and manage sensitive information, such as passwords, OAuth tokens, and SSH keys. You can deploy and update secrets and application configuration without rebuilding your container images, and without exposing secrets in your stack configuration.

Kubernetes is not a mere orchestration system. It eliminates the need for orchestration. The technical definition of orchestration is execution of a defined workflow: first do A, then B, then C. **In contrast, Kubernetes comprises a set of independent, composable control processes that continuously drive the current state towards the provided desired state. It shouldn't matter how you get from A to C.** Centralized control is also not required. This results in a system that is easier to use and more powerful, robust, resilient, and extensible.

![Kubernetes Architecture](./img/kubernetes_arch.png)

---

## Notes to Self

- To check path of poetry environment use the command `poetry env info`.  My path is currently located at /~/Library/Caches/pypoetry/virtualenvs/capstone-XWfwnle5-py3.10.  So to reactivate this virtual environment I would use:
  - `source ~/Library/Caches/pypoetry/virtualenvs/capstone-XWfwnle5-py3.10 activate`
- Ran into a warning in the construction of my Dockerfile (i.e., Dockerfile:10 DL4006 warning: Set the SHELL option -o pipefail before RUN with a pipe in it).  Here are the two URLs that helped me fixed these errors.
  - <https://githubmemory.com/repo/hadolint/hadolint/issues/724>
  - <https://github.com/hadolint/hadolint/wiki/DL4006>
- The pylintrc file is the configuration file for the pylint package.  I generated this config file typing the following command `pylint --generate-rcfile > pylintrc`. More information can be found here: <https://pylint.pycqa.org/en/latest/user_guide/options.html>.
- **Date 11/24/2021** - I really should separate these two application (Dagster and Flask app).  They should each have their own work flow and repository.  Then I would not be duplicating so much of my CI/CD.  Also, it would allow me to more easily explore where I which environment I want to deploy process too. I will continue with Dagster. You need a repository for each thing you want to deploy.
- [Something to help with dagster.yaml file](https://github.com/dagster-io/dagster/issues/3079)
- [Pytest Coverage](https://breadcrumbscollector.tech/how-to-use-code-coverage-in-python-with-pytest/)
- [Wget for downloading content to linux](https://linuxize.com/post/wget-command-examples/)
- [Permission Denied: execute bash script](https://careerkarma.com/blog/bash-permission-denied-solution/)
- [Exit from Bash Script on Failure of Command](https://intoli.com/blog/exit-on-errors-in-bash-scripts/)
- [mkdir options](https://www.javatpoint.com/linux-mkdir-p)
- To execute the environement file use the following commands: `source .env`
- [What is the difference between 127.0.0.1 and 0.0.0.0](https://www.howtogeek.com/225487/what-is-the-difference-between-127.0.0.1-and-0.0.0.0/#:~:text=In%20the%20context%20of%20servers,has%20two%20IP%20addresses%2C%20192.168.&text=2.1%2C%20and%20a%20server%20running,at%20both%20of%20those%20IPs.)
  - `127.0.0.1` is the loopback address (also known as localhost). The address is used to establish an IP connection to the same machine or computer being used by the end-user.
  - `0.0.0.0` is a non-routable meta-address used to designate an invalid, unknown, or non-applicable target (a ‘no particular address’ place holder). In the context of a route entry, it usually means the default route. In the context of servers, 0.0.0.0 means all IPv4 addresses on the local machine. If a host has two IP addresses, 192.168.1.1 and 10.1.2.1, and a server running on the host listens on 0.0.0.0, it will be reachable at both of those IPs.
- [Docker Layers Reference 1](https://dzone.com/articles/docker-layers-explained)
- [Docker Layers Reference 2](https://jessicagreben.medium.com/digging-into-docker-layers-c22f948ed612)
- [Dockerfile Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
- [What does backslash do at the end](https://unix.stackexchange.com/questions/368753/what-does-this-command-with-a-backslash-at-the-end-do)
- A database cluster is a collection of databases that are managed by a single server instance.
- [Setting default variable values in bash scripts](https://stackoverflow.com/questions/2013547/assigning-default-values-to-shell-variables-with-a-single-command-in-bash)
- [Setting default arguments](https://stackoverflow.com/questions/9332802/how-to-write-a-bash-script-that-takes-optional-input-arguments)
- [Understand Entrypoints](https://docs.docker.com/engine/reference/builder/#entrypoint)
- [Docker compose, Flask App & PostgresDB](https://levelup.gitconnected.com/dockerizing-a-flask-application-with-a-postgres-database-b5e5bfc24848)
- [Docker compose another example](https://levelup.gitconnected.com/creating-and-filling-a-postgres-db-with-docker-compose-e1607f6f882f)
- [Top 30 Git Commands to Master](https://levelup.gitconnected.com/top-30-git-commands-you-should-know-to-master-git-cli-f04e041779bc)
- [Networking in Docker Compose](https://docs.docker.com/compose/networking/)
- [Docker Compose in Production](https://docs.docker.com/compose/production/)
- [Docker-Compose Command Reference](https://docs.docker.com/compose/reference/push/)
- [Docker-Compose to Kubernetes](https://loft.sh/blog/docker-compose-to-kubernetes-step-by-step-migration/)
  - Docker-Compose combines microservices into 1 docker file.  However, this microservice is supposed to run on one host (one virtual machine or computer).  Kubernetes runs containers across many hosts (virtual machines).  So microservices (which are multiple containers) may not all be on the same hosts. When working with a Docker Compose-based application, the server running the application must be kept running for the application to continue working. This means the server running Compose becomes a single point of failure. In contrast, Kubernetes usually is run in a highly available (HA) state with multiple servers that deploy and maintain the application to the different nodes. Kubernetes also manages the scaling of the nodes based on resource utilization.
