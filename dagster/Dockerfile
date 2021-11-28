# syntax=docker/dockerfile:1

FROM cimg/python:3.9.7 

LABEL role="data-processing"
LABEL purpose="Data processing of client schemas and schema changes."
LABEL reference="https://docs.dagster.io/deployment/dagster-instance#compute-log-storage"

# Was running into permission denied errors, so followed the suggestion of this link:
# https://stackoverflow.com/questions/45553074/cannot-create-directory-permission-denied-inside-docker-container
# http://www.freekb.net/Article?id=3385
# Changing ownership of opt folder to build_user and build_user group
USER root

RUN pip install -U pip && \
    pip install dagster dagit dagster-postgres dagster-aws dagster-k8s

RUN useradd build_user && \
    mkdir -p /opt && \
    chown build_user /opt && \ 
    chgrp build_user /opt
    
USER build_user

# Want to put all these mkdir (make directory) in one line so that it will be in 1 docker layer
# Only the command: RUN, COPY, ADD, ENV create layers
RUN mkdir -p /opt/dagster/app \
    /opt/dagster/dagster_home \
    /opt/dagster/local

# Copy your code and workspace to /opt/dagster/app
COPY workspace.yaml /opt/dagster/app/

# Copy code and workspace to /opt/dagster/app
COPY dagster_capstone/ /opt/dagster/app/

ENV DAGSTER_HOME=/opt/dagster/dagster_home/

# Copy dagster instance YAML to $DAGSTER_HOME
COPY dagster.yaml /opt/dagster/dagster_home/

WORKDIR /opt/dagster/app

EXPOSE 3000
# Opening the Dagster UI
# Using 0.0.0.0 because I want any IP address on the machine, when using port 3000
# to go to the dagster app
ENTRYPOINT ["dagit", "-h", "0.0.0.0", "-p", "3000"]