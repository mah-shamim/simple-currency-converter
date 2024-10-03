ls -l /home/ubuntu/.minikube/profiles/minikube/
sudo chmod 644 /home/ubuntu/.minikube/profiles/minikube/client.crt
sudo chmod 644 /home/ubuntu/.minikube/profiles/minikube/client.key
sudo chmod 644 /home/ubuntu/.minikube/ca.crt
ls -l /home/ubuntu/.minikube/profiles/minikube/
sudo chown jenkins:jenkins /home/ubuntu/.minikube/profiles/minikube/client.crt
sudo chown jenkins:jenkins /home/ubuntu/.minikube/profiles/minikube/client.key
sudo chown jenkins:jenkins /home/ubuntu/.minikube/ca.crt
ls -l /home/ubuntu/.minikube/profiles/minikube/



kubectl proxy --port=8001
kubectl get services -n kubernetes-dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.5/aio/deploy/recommended.yaml --validate=false
kubectl get services -n kubernetes-dashboard
kubectl get pods -n kubernetes-dashboard
minikube addons enable dashboard
minikube addons enable metrics-server
kubectl get services -n kubernetes-dashboard
kubectl get endpoints -n kubernetes-dashboard
kubectl create serviceaccount dashboard-admin -n kubernetes-dashboard
kubectl create clusterrolebinding dashboard-admin --clusterrole=cluster-admin --serviceaccount=kubernetes-dashboard:dashboard-admin
