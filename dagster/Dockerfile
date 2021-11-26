# syntax=docker/dockerfile:1

FROM cimg/python:3.9.7
#FROM python:3.10.0-slim 

LABEL role="Backend"
LABEL purpose="Data processing of client schemas and schema changes."
LABEL reference="https://docs.dagster.io/deployment/dagster-instance#compute-log-storage"

RUN sudo mkdir -p /opt/dagster/dagster_home /opt/dagster/app /opt/dagster/local

RUN pip install -U pip && \
    pip install dagster dagit dagster-postgres

# Copy your code and workspace to /opt/dagster/app
COPY dagster_capstone/hello_world.py workspace.yaml /opt/dagster/app/

# Copy code and workspace to /opt/dagster/app
COPY dagster_capstone/ /opt/dagster/app/

ENV DAGSTER_HOME=/opt/dagster/dagster_home/

# Copy dagster instance YAML to $DAGSTER_HOME
COPY dagster.yaml /opt/dagster/dagster_home/

WORKDIR /opt/dagster/app

EXPOSE 3000

# Opening the Dagster UI
ENTRYPOINT ["dagit", "-h", "0.0.0.0", "-p", "3000"]