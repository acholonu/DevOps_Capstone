# Overview

This folder holds the definition for the database image used for the dagster app.  Dagster will place all its system information to this database.

## Files

- **init_dagster_db.sh**: is the script that goes into the image and initializes the dagster user and password.  This supports security, since the dagster database user has limited priviledges and is not the super user.

- **Dockerfile**: Defines the postgres database that the dagster app will use.  So basically constructs the dagster image.

## Other notes

I will see if I want to combine this into the Dagster App Dockerfile.  So do a multi-stage build where this application is included.  It makes sense to do a multi-stage build because these two application (postgres database and dagster app) will always be working together.
