```
sudo vim ci.sh
sudo chmod +x ci.sh 
./ci.sh 
```
```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
(OPTIONAL)
```
kubectl create serviceaccount jenkins-sa
kubectl create clusterrolebinding jenkins-role-binding --clusterrole=cluster-admin --serviceaccount=default:jenkins-sa
kubectl get secret $(kubectl get serviceaccount jenkins-sa -o jsonpath='{.secrets[0].name}') -o jsonpath='{.data.token}' | base64 --decode
kubectl config view --raw
```
```
sudo chown -R jenkins:jenkins /home/ubuntu/.minikube/profiles/minikube
sudo chmod 600 /home/ubuntu/.minikube/profiles/minikube/client.crt /home/ubuntu/.minikube/profiles/minikube/client.key ~/.minikube/ca.crt
sudo chown -R jenkins:jenkins /home/ubuntu/.kube/config
sudo chown -R jenkins:jenkins /home/ubuntu/.minikube/profiles/minikube
sudo -u jenkins minikube status
minikube profile list
sudo chown -R ubuntu:ubuntu /home/ubuntu/.minikube
sudo chmod -R 755 /home/ubuntu/.minikube
minikube delete
minikube start --driver=docker
sudo chown $USER $HOME/.kube/config && chmod 600 $HOME/.kube/config
minikube start --driver=docker
sudo chown -R jenkins:jenkins /home/ubuntu/.minikube
sudo chmod -R 755 /home/ubuntu/.minikube
sudo chown -R ubuntu:ubuntu /home/ubuntu/.minikube/profiles/minikube
sudo chmod 600 /home/ubuntu/.minikube/profiles/minikube/client.crt /home/ubuntu/.minikube/profiles/minikube/client.key ~/.minikube/ca.crt
sudo chown -R jenkins:jenkins /home/ubuntu/.minikube/profiles/minikube
sudo chmod 600 /home/ubuntu/.minikube/profiles/minikube/client.crt /home/ubuntu/.minikube/profiles/minikube/client.key ~/.minikube/ca.crt
sudo chown -R jenkins:jenkins /home/ubuntu/.kube/config
sudo chown -R jenkins:jenkins /home/ubuntu/.minikube/profiles/minikube
minikube status
minikube update-context
sudo chown $USER $HOME/.kube/config && chmod 600 $HOME/.kube/config
sudo chown -R ubuntu:ubuntu /home/ubuntu/.minikube

sudo chmod o+rx /home/ubuntu
sudo chmod o+rx /home/ubuntu/.minikube
sudo chmod o+rx /home/ubuntu/.minikube/profiles
sudo chmod o+rx /home/ubuntu/.minikube/profiles/minikube

ls -l /home/ubuntu/.minikube/profiles/minikube/
sudo chmod 644 /home/ubuntu/.minikube/profiles/minikube/client.crt
sudo chmod 644 /home/ubuntu/.minikube/profiles/minikube/client.key
sudo chmod 644 /home/ubuntu/.minikube/ca.crt

ls -l /home/ubuntu/.minikube/profiles/minikube/
sudo chown jenkins:jenkins /home/ubuntu/.minikube/profiles/minikube/client.crt
sudo chown jenkins:jenkins /home/ubuntu/.minikube/profiles/minikube/client.key
sudo chown jenkins:jenkins /home/ubuntu/.minikube/ca.crt

ls -l /home/ubuntu/.minikube/profiles/minikube/
```