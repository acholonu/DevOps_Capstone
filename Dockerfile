# syntax=docker/dockerfile:1

# Set base image
FROM cimg/python:3.9.7

# Add tags
LABEL role "Frontend"

# Set working directory for containter
WORKDIR /app

# Install Dependencies
RUN pip install Flask

# Copy source files to container app directory (i.e., working directory)
COPY sample_app/ .

# Define how to execute this docker image (i.e., entry point)
# This structure for CMD is based on the python subprocess module (https://docs.python.org/3/library/subprocess.html)
# Note that we need to make the application externally visible (i.e. from outside the container) by specifying --host=0.0.0.0.
CMD [ "python", "-m", "flask", "run","--host=0.0.0.0"]