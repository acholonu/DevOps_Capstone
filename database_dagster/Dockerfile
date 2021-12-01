# syntax=docker/dockerfile:1

# So building off another image
FROM postgres:latest

ENV POSTGRES_PASSWORD=$POSTGRES_SUPER_USER_PASSWORD
ENV POSTGRES_USER=$POSTGRES_SUPER_USER
ENV POSTGRES_DB=$POSTGRES_DATABASE
ENV DAGSTER_POSTGRES_USER=$DAGSTER_POSTGRES_USER
ENV DAGSTER_POSTGRES_PASSWORD=$DAGSTER_POSTGRES_PASSWORD

# Expose port 5432
EXPOSE 5432

# Copy initialization script to initialization folder
COPY init_dagster_db.sh /docker-entrypoint-initdb.d/

# The command to execute
CMD ["postgres"]

