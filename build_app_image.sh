# The docker build command builds Docker images from a Dockerfile and a “context”. 
# A build’s context is the set of files located in the specified PATH or URL. 
# The Docker build process can access any of the files located in this context.

# Build
# --------
# So I saying build an image, that I am naming (using the --tag option)
# sample_flask_app with at tag of beta. If I leave off the :beta, the
# default tag is `latest`. By default, docker will look for a file name Dockerfile.
# So docker will create the image based on the instruction in the Dockerfile.
# I am setting the context to be all the files in the sample_app folder. 
# So image will only access files in the sample_app folder.
docker build --tag sample_flask_app:beta sample_app

# Building images with a different Dockerfile naming scheme
# ---------------------------------------------------------
# How to run the docker files
docker build -f Dagster.Dockerfile .
docker build -f DB.Dockerfile .