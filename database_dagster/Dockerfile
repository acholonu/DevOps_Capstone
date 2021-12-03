# syntax=docker/dockerfile:1

# Building off the official postgres image
# ----------------------------------------
# Using the latest postgres docker image
FROM postgres:latest

# Set the superuser and dagster user
# ----------------------------------
ENV POSTGRES_DB=$POSTGRES_DATABASE
ENV POSTGRES_USER=$POSTGRES_SUPER_USER
ENV POSTGRES_PASSWORD=$POSTGRES_SUPER_USER_PASSWORD
ENV DAGSTER_POSTGRES_USER=$DAGSTER_POSTGRES_USER
ENV DAGSTER_POSTGRES_PASSWORD=$DAGSTER_POSTGRES_PASSWORD

# Create directory that Postgres will look for to do initialization
# -----------------------------------------------------------------
RUN mkdir /docker-entrypoint-initdb.d/

# Copy initialization script to initialization folder
# ----------------------------------------------------
# The initialization script creates the dagster user and grants
# permission
COPY init_dagster_db.sh /docker-entrypoint-initdb.d/

# Copy sql code that creates some sample tables into the database
# ---------------------------------------------------------------
# data came from here: https://www.postgresql.org/ftp/projects/pgFoundry/dbsamples/world/dbsamples-0.1/
COPY world.sql /docker-entrypoint-initdb.d/

# Expose port 5432
EXPOSE 5432

# The command to execute
# CMD ["postgres"]

