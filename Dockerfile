# syntax=docker/dockerfile:1

FROM python:3.10.0-slim 

LABEL maintainer "Ugochi Jones <ucachlonu@hotmail.com>"

ENV POETRY_VERSION 1.1.11

# Install Poetry
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN set -eu; \
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py \
        | python - --version "${POETRY_VERSION}"; \
    find "/root/.local/share/pypoetry" -not -user 0 -exec chown 0:0 '{}' \;;

ENV PATH="/root/.local/bin:$PATH"

RUN mkdir -p /opt/dagster/dagster_home /opt/dagster/app
#RUN pip install dagit dagster-postgres

# Copy your code and workspace to /opt/dagster/app
COPY dagster_capstone/ /opt/dagster/app/

ENV DAGSTER_HOME=/opt/dagster/dagster_home/

# Copy dagster instance YAML to $DAGSTER_HOME
COPY dagster.yaml /opt/dagster/dagster_home/

WORKDIR /opt/dagster/app

EXPOSE 3000

ENTRYPOINT ["dagit", "-h", "0.0.0.0", "-p", "3000"]