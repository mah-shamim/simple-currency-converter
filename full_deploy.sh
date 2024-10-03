#!/bin/bash

CONTAINER_NAME="currency_converter_app"
DOCKER_IMAGE_TAG="currency_converter:$BUILD_ID"
PORT=9191

# Check if the container is running
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Stopping and removing existing container..."
    docker stop $CONTAINER_NAME || { echo "Failed to stop container! Exiting."; exit 1; }
    docker rm $CONTAINER_NAME || { echo "Failed to remove container! Exiting."; exit 1; }
fi

# Build the Docker image
echo "Building Docker image with tag $DOCKER_IMAGE_TAG..."
docker build -t $DOCKER_IMAGE_TAG . || { echo "Docker build failed! Exiting."; exit 1; }

# Run the container
echo "Running Docker container on port $PORT..."
docker run -d -p $PORT:80 --name $CONTAINER_NAME $DOCKER_IMAGE_TAG || { echo "Failed to start Docker container! Exiting."; exit 1; }

# Deploy to Kubernetes
echo "Deploying to Kubernetes..."
kubectl apply -f k8s-deployment.yml --validate=false || { echo "Failed to apply Kubernetes deployment! Exiting."; exit 1; }
kubectl apply -f k8s-service.yml --validate=false || { echo "Failed to apply Kubernetes service! Exiting."; exit 1; }

# Log some debugging information
echo "Currently running Docker containers:"
docker ps

echo "Current Kubernetes deployments:"
kubectl get deployments

echo "Current Kubernetes services:"
kubectl get services
