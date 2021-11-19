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

# Viewing Images
# --------------
# To see all the images on your local machine
docker images

# Add another tag to an image
# ----------------------------
# The docker tag command creates a new tag for an image. It does not create a new image.
# The tag points to the same image and is just another way to reference the image. 
# Both tags will show up if you do the `docker images` command and their image ids will be 
# the same. Again, tags are just another
docker tag sample_flask_app:latest sample_flask_app:v1.0.0

# Removing a Tag
# --------------
docker rmi sample_flask_app:v1.0.0

# Running a Container
# -------------------
# A container is a normal operating system process except that this process is isolated in that 
# it has its own file system, its own networking, and its own isolated process tree separate from the host.
# To run an image inside of a container, we use the docker run command. The docker run command requires one 
# parameter which is the name of the image. 
#
# After running this command, you’ll notice that you were not returned to the command prompt. 
# This is because our application is a REST server and runs in a loop waiting for incoming 
# requests without returning control back to the OS until we stop the container.
docker run sample_flask_app

# To test the flask app, send a GET request using curl
curl localhost:5000

# Result is an Error: curl: (7) Failed to connect to localhost port 5000: Connection Refused
# This is expected because our container is running in isolation which includes networking. 
# Let’s stop (i.e., ctrl-c) the container and restart with port 5000 published on our local network.

# Run a Container with Port Exposed/Published
# -------------------------------------
# To publish a port for our container, we’ll use the --publish flag (-p for short) on the docker run
# command. The format of the --publish command is [host port]:[container port]. So, if we wanted to 
# expose port 5000 inside the container to port 3000 outside the container, we would pass 3000:5000 
# to the --publish flag.
docker run --publish 5000:5000 sample_flask_app # --publish [host port]:[container port]
# same as
docker run -p 5000:5000 sample_flask_app

# Run a Container in Detached (Background) mode
# ---------------------------------------------
docker run --detach -p 5000:5000 sample_flask_app
# same as
docker run -d -p 5000:5000 sample_flask_app

# Name a Container
# ----------------
#
docker run -d -p 5000:5000 --name my_flask_app_container sample_flask_app
# docker run -d -p [Host port]:[Container port] --name <container name> <image name>

# List Running Containers (and their information)
# -----------------------------------------------
# Remember containers are running Operating System processes, isolated in a box (i.e., container). 
# The container only know the contents in their own "context".  So its own file system, its own operating system
# its own networking, its own code (i.e., computer). 
#
# Since we ran our container in the background, how do we know if our container is running or what other containers 
# are running on our machine? Well, we can run the docker ps command. Just like on Linux to see a list of processes 
# on your machine, we would run the ps command. In the same spirit, we can run the docker ps command which displays a 
# list of containers running on our machine.
#
# The docker ps command provides a bunch of information about our running containers. We can see the container ID, 
# The image running inside the container, the command that was used to start the container, when it was created, the status, 
# ports that exposed and the name of the container.
#
# You are probably wondering where the name of our container is coming from. Since we didn’t provide a name for the container 
# when we started it, Docker generated a random name. We’ll fix this in a minute, but first we need to stop the container. 
docker ps
docker ps --all # shows all docker containers whether they are running or not
# same as
docker ps -a 

# Stop and Start a Container
# --------------------------
# When we stop a container, it is not removed, but the status is changed to stopped and the process inside the container is stopped.
docker stop <container name>
docker restart <container name>

# Remove a container
# ------------------
# When you remove a container, it is no longer running, nor it is in the stopped status, but the process inside the container has been stopped 
# and the metadata for the container has been removed.
 docker rm <container name1> <container name2> <container name3>


# Connecting Database to our application
# ----------------------------------------
# ----------------------------------------

# Create a Docker Volume to persist data
# --------------------------------------
