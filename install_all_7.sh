#!/bin/bash

# Function to check if a command exists
command_exists() {
  command -v "$@" >/dev/null 2>&1
}

# Exit immediately if a command exits with a non-zero status
set -e
set -x  # Enable debug logging

# Define Variables
DOCKER_USER="docker"
JENKINS_USER="jenkins"
MINIKUBE_PROFILE_DIR="/home/ubuntu/.minikube/profiles/minikube"
KUBECONFIG_DIR="/home/ubuntu/.kube/config"
USER_HOME="/home/ubuntu"
DOCKER_GROUP="docker"

# Update and install dependencies
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install -y curl unzip git wget gnupg2 apt-transport-https ca-certificates gnupg lsb-release software-properties-common

# Docker Installation
if ! command_exists docker; then
    echo "Installing Docker..."

    if [ ! -f /usr/share/keyrings/docker-archive-keyring.gpg ]; then
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    fi

    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    sudo usermod -aG $DOCKER_GROUP $USER
    sudo systemctl start docker
    sudo systemctl enable docker
fi

# Minikube Installation
if ! command_exists minikube; then
    echo "Installing Minikube..."
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    rm minikube-linux-amd64
    sudo -u $USER minikube start --driver=docker
    sudo chown -R $USER:$USER ~/.minikube
fi

# Kubectl Installation
if ! command_exists kubectl; then
    echo "Installing kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/kubectl
    mkdir -p ~/.kube
    sudo chown -R $USER:$USER ~/.kube
    #sudo snap install kubelet --classic
    #sudo snap install kubeadm --classic
    #kubeadm config print init-defaults > old.yaml
    #kubeadm config migrate --old-config old.yaml --new-config new.yaml
fi

# Terraform Installation
if ! command_exists terraform; then
    echo "Installing Terraform..."
    wget https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_amd64.zip
    unzip terraform_1.5.0_linux_amd64.zip
    sudo mv terraform /usr/local/bin/
    rm terraform_1.5.0_linux_amd64.zip
fi

# Ansible Installation
if ! command_exists ansible; then
    echo "Installing Ansible..."
    sudo apt-get update -y
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    sudo apt-get install -y ansible

    # Verify Ansible installation
    echo "Verifying Ansible installation..."
    ansible --version

    # Set up Ansible configuration and host inventory for localhost
    echo "Setting up Ansible configuration..."

    # Create Ansible directories
    mkdir -p ~/ansible

    # Create Ansible hosts file
    sudo tee ~/ansible/hosts > /dev/null <<EOL
[local]
localhost ansible_connection=local
EOL

    # Create Ansible configuration file
    sudo tee ~/ansible/ansible.cfg > /dev/null <<EOL
[defaults]
inventory = ~/ansible/hosts
host_key_checking = False
EOL

    # Test Ansible Setup
    echo "Running Ansible ping on localhost..."
    ansible local -m ping

fi

# Java Installation
if ! command_exists java; then
    echo "Installing Java..."
    sudo apt-get install -y openjdk-17-jre
fi

# Jenkins Installation
if ! command_exists jenkins; then
    echo "Installing Jenkins..."
    sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian/jenkins.io-2023.key
    echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y jenkins
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
fi

# Prometheus Installation
if ! command_exists prometheus; then
    echo "Installing Prometheus..."
    wget https://github.com/prometheus/prometheus/releases/download/v2.32.0/prometheus-2.32.0.linux-amd64.tar.gz
    tar xvfz prometheus-2.32.0.linux-amd64.tar.gz
    sudo mv prometheus-2.32.0.linux-amd64/prometheus /usr/local/bin/
    sudo mv prometheus-2.32.0.linux-amd64/promtool /usr/local/bin/
    sudo mv prometheus-2.32.0.linux-amd64/consoles /etc/prometheus/
    sudo mv prometheus-2.32.0.linux-amd64/console_libraries /etc/prometheus/
    rm -rf prometheus-2.32.0.linux-amd64.tar.gz prometheus-2.32.0.linux-amd64/
fi

# Grafana Installation
if ! command_exists grafana-server; then
    echo "Installing Grafana..."
    curl -fsSL https://packages.grafana.com/gpg.key | sudo tee /etc/apt/trusted.gpg.d/grafana.asc
    echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee /etc/apt/sources.list.d/grafana.list
    sudo apt-get update
    sudo apt-get install -y grafana
    sudo systemctl enable grafana-server
    sudo systemctl start grafana-server
fi

# Permissions and Jenkins Docker Setup
if command_exists docker && command_exists jenkins; then
    sudo usermod -aG $DOCKER_USER $JENKINS_USER
    sudo chmod 666 /var/run/docker.sock
fi

# Generate SSH keys for Jenkins if they do not exist
if [ ! -f /var/lib/jenkins/.ssh/id_rsa ]; then
    sudo -u jenkins ssh-keygen -t rsa -b 4096 -f /var/lib/jenkins/.ssh/id_rsa -N ""
fi

# Configure Kubernetes access for Jenkins
sudo mkdir -p /etc/kubernetes/admin.conf.d
sudo cp ~/.kube/config /etc/kubernetes/admin.conf.d/kubeconfig
sudo chown root:root /etc/kubernetes/admin.conf.d/kubeconfig
sudo chmod 644 /etc/kubernetes/admin.conf.d/kubeconfig

sudo mkdir -p /var/lib/jenkins/.kube
sudo ln -s /etc/kubernetes/admin.conf.d/kubeconfig /var/lib/jenkins/.kube/config
sudo chown -h jenkins:jenkins /var/lib/jenkins/.kube/config

# Allow Jenkins to execute kubectl and minikube without password
echo "jenkins ALL=(ALL) NOPASSWD: /usr/local/bin/minikube, /usr/local/bin/kubectl" | sudo tee -a /etc/sudoers.d/jenkins

# Restart Jenkins to apply group changes
sudo systemctl restart jenkins

# Start Minikube as ubuntu user
minikube delete
minikube start --driver=docker

# Apply Kubernetes Dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.5/aio/deploy/recommended.yaml --validate=false

# Create Service Account and ClusterRoleBinding for Dashboard
kubectl create serviceaccount dashboard-admin -n kubernetes-dashboard
kubectl create clusterrolebinding dashboard-admin --clusterrole=cluster-admin --serviceaccount=kubernetes-dashboard:dashboard-admin
minikube addons enable dashboard
minikube addons enable metrics-server

# Start kubectl proxy in the background
kubectl proxy &

# Print completion message
echo "Installation and configuration completed successfully."