#!/bin/bash

CONTAINER_NAME="currency_converter_app"
DOCKER_IMAGE_TAG="currency_converter:$BUILD_ID mahshamim/currency_converter:$BUILD_ID"
PORT=9090

# Check if the container is running
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Stopping and removing existing container..."
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
fi

# Build the Docker image
echo "Building Docker image with tag $DOCKER_IMAGE_TAG..."
docker build -t $DOCKER_IMAGE_TAG .

# Run the container
echo "Running Docker container on port $PORT..."
docker run -d -p $PORT:80 --name $CONTAINER_NAME $DOCKER_IMAGE_TAG
