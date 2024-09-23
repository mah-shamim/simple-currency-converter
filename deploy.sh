#!/bin/bash

# Clone the repository
git clone https://github.com/mah-shamim/simple-calculator.git
cd simple-calculator

# Build Docker image
docker build -t simple-calculator .

# Run Ansible playbook
ansible-playbook deploy.yml

# Apply Terraform infrastructure
cd terraform
terraform init
terraform apply -auto-approve

# Deploy to Kubernetes
kubectl apply -f deployment.yaml

# Check the status of the Kubernetes pods and services
kubectl get pods
kubectl get svc