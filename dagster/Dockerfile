# syntax=docker/dockerfile:1

#FROM cimg/python:3.9.7 AS dagit
FROM python:3.9.9-slim AS dagster

LABEL microservice="dagster"
LABEL role="data-processing"
LABEL purpose="Data processing of client schemas and schema changes."
LABEL reference="https://docs.dagster.io/deployment/dagster-instance#compute-log-storage"

# Was running into permission denied errors, so followed the suggestion of this link:
# https://stackoverflow.com/questions/45553074/cannot-create-directory-permission-denied-inside-docker-container
# http://www.freekb.net/Article?id=3385
# Changing ownership of opt folder to build_user and build_user group
USER root

RUN pip install -U pip && \
    pip install dagster dagit dagster-graphql dagster-postgres dagster-aws dagster-k8s dagster-docker

RUN useradd build_user && \
    mkdir -p /opt && \
    chown build_user /opt && \ 
    chgrp build_user /opt
    
USER build_user

# Want to put all these mkdir (make directory) in one line so that it will be in 1 docker layer
# Only the command: RUN, COPY, ADD, ENV create layers
# I am mirroring local file structure to container's file structure
RUN mkdir -p /opt/dagster/dagster_capstone \
    /opt/dagster/dagster_home \
    /opt/dagster/local \
    /opt/dagster/logs

# Copy your code and workspace to /opt/dagster/app
#COPY workspace.yaml /opt/dagster/dagster_capstone/
COPY workspace.yaml /opt/dagster/

# Copy code and workspace to /opt/dagster/app
COPY dagster_capstone/ /opt/dagster/dagster_capstone/

ENV DAGSTER_HOME=/opt/dagster/dagster_home/
ENV POSTGRES_USER=$POSTGRES_USER
ENV POSTGRES_HOSTNAME=$POSTGRES_HOSTNAME
ENV POSTGRES_DB=$POSTGRES_DB
ENV POSTGRES_PASSWORD=$POSTGRES_PASSWORD
ENV S3_BUCKET=$S3_BUCKET
ENV S3_LOG_PREFIX=$S3_LOG_PREFIX

# Copy dagster instance YAML to $DAGSTER_HOME
COPY dagster.yaml /opt/dagster/dagster_home/

WORKDIR /opt/dagster/

FROM dagster AS dagit
LABEL role="Graphical Interface: Admin Tool for Dagster"

EXPOSE 3000
# Opening the Dagster UI
# Using 0.0.0.0 because I want any IP address on the machine, when using port 3000
# to go to the dagster app
# An ‘entrypoint’ gives you the ability to run the container as an executable. 

#ENTRYPOINT ["dagit", "-h", "0.0.0.0", "-p", "3000"]
CMD ["dagit", "-h", "0.0.0.0", "-p", "3000"]

# FROM dagster AS user_code

# # Run dagster gRPC server on port 4000
# EXPOSE 4000

# # Using CMD rather than ENTRYPOINT allows the command to be overridden in
# # run launchers or executors to run other commands using this image
# CMD ["dagster", "api", "grpc", "-h", "0.0.0.0", "-p", "4000", "-f", "dagster_capstone/repository.py"]