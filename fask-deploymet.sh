#!/bin/bash

# Define variables
GITHUB_REPO="https://github.com/viv2233/test-server.git"
DOCKER_IMAGE_NAME="myapp"
BUILD_TAG="build-1"  # You can modify this for different builds
CONTAINER_PORT=3000
HOST_PORT=3000

# 1. Clone the GitHub Repository
#
#sudo apt update -y
#sleep 10
sudo apt  install docker.io -y
sudo usermod -aG docker $USER
sudo chmod 777
echo "Cloning the repository..."
git clone ${GITHUB_REPO}
cd test-server || { echo "Failed to navigate to project directory"; exit 1; }

# 2. Build the Docker Image
echo "Building Docker image ${DOCKER_IMAGE_NAME}:${BUILD_TAG}..."
docker build -t ${DOCKER_IMAGE_NAME}:${BUILD_TAG} . || { echo "Docker build failed"; exit 1; }

# 3. Run the Docker Container
echo "Running Docker container ${DOCKER_IMAGE_NAME}-${BUILD_TAG}..."
docker run -d --name ${DOCKER_IMAGE_NAME}-${BUILD_TAG} -p ${HOST_PORT}:${CONTAINER_PORT} ${DOCKER_IMAGE_NAME}:${BUILD_TAG} || { echo "Docker run failed"; exit 1; }

# 4. Check Docker Container Logs
echo "Checking logs of the container ${DOCKER_IMAGE_NAME}-${BUILD_TAG}..."
docker logs ${DOCKER_IMAGE_NAME}-${BUILD_TAG}

# 5. Clean Up the Container and Image
echo "Cleaning up..."
#docker rm -f ${DOCKER_IMAGE_NAME}-${BUILD_TAG} || true  # Ignore errors if container doesn't exist
#docker rmi ${DOCKER_IMAGE_NAME}:${BUILD_TAG} || true    # Ignore errors if image doesn't exist

# 6. Optional Docker System Prune (removes unused containers, images, and volumes)
echo "Pruning unused Docker data..."
#docker system prune -f
